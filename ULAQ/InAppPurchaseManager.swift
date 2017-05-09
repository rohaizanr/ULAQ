//
//  InAppPurchaseManager.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 10/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//


import StoreKit
import SpriteKit

protocol InAppPurchaseManagerDelegate: class {
    func didFinishTask(sender: InAppPurchaseManager)
    func transactionInProgress(sender: InAppPurchaseManager)
    func transactionCompleted(sender: InAppPurchaseManager)
}

class InAppPurchaseManager: NSObject, SKProductsRequestDelegate,SKPaymentTransactionObserver {
    
    var productID = ""
    var productsRequest = SKProductsRequest()
    var iapProducts = [SKProduct]()
    
    var parent: SKScene?

    weak var delegate:InAppPurchaseManagerDelegate?
    
    override init() {
        self.productID = ""
        self.productsRequest = SKProductsRequest()
        self.iapProducts = [SKProduct]()
        
        super.init()
        
        self.fetchAvailableProducts()
    }
    
    func fetchAvailableProducts()  {
        delegate?.transactionInProgress(sender: self)
        let productIdentifiers = NSSet(objects:PREMIUM_PROD_ID)
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    func buyPremium(){
        delegate?.transactionInProgress(sender: self)
        purchaseMyProduct(product: iapProducts[0])
    }
    
    func restorePurchase(){
        delegate?.transactionInProgress(sender: self)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // MARK: - RESTORE
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        delegate?.transactionCompleted(sender: self)
        
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
            case PREMIUM_PROD_ID:
                UnlockSkinManager().buyPremium()
                
                let purchaceAlert = UIAlertController(title: "Restore Purchase Successful!", message: "You have successfully restored your purchase.", preferredStyle: UIAlertControllerStyle.alert)
                
                purchaceAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in
                    print("Close")
                }))
                
                let vc = parent?.view?.window?.rootViewController
                if vc?.presentedViewController == nil {
                    vc?.present(purchaceAlert, animated: true, completion: nil)
                }
                
                delegate?.didFinishTask(sender: self)
                
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                let purchaceAlert = UIAlertController(title: "Restore Purchase Failed!", message: "You have not made any purchase.", preferredStyle: UIAlertControllerStyle.alert)
                
                purchaceAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in
                    print("Close")
                }))
                
                let vc = parent?.view?.window?.rootViewController
                if vc?.presentedViewController == nil {
                    vc?.present(purchaceAlert, animated: true, completion: nil)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    // MARK: - RESTORE ERROR
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        delegate?.transactionCompleted(sender: self)
        
        let purchaceAlert = UIAlertController(title: "Restore Purchase Failed!", message: "You have not made any purchase.", preferredStyle: UIAlertControllerStyle.alert)
        
        purchaceAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in
            print("Close")
        }))
        
        let vc = parent?.view?.window?.rootViewController
        if vc?.presentedViewController == nil {
            vc?.present(purchaceAlert, animated: true, completion: nil)
        }
    }

    // MARK: - REQUEST IAP PRODUCTS
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        delegate?.transactionCompleted(sender: self)
        
        if (response.products.count > 0) {
            iapProducts = response.products
        }
    }
    
    // MARK:- IAP PAYMENT QUEUE
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        delegate?.transactionCompleted(sender: self)
        
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                    
                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    
                    if productID == PREMIUM_PROD_ID {
                        UnlockSkinManager().buyPremium()
                        
                        let purchaceAlert = UIAlertController(title: "Purchase Successful!", message: "Thank you for buying. Hope you will enjoy the game.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        purchaceAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in
                            print("Close")
                        }))
                        
                        let vc = parent?.view?.window?.rootViewController
                        if vc?.presentedViewController == nil {
                            vc?.present(purchaceAlert, animated: true, completion: nil)
                        }
                        
                        delegate?.didFinishTask(sender: self)
                    }
                    
                    break
                    
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .restored:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                default: break
                }
            }
        }
    }
    
    // MARK: - MAKE PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    func purchaseMyProduct(product: SKProduct) {
        delegate?.transactionCompleted(sender: self)
        
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            print("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
        } else {
            // IAP Purchases dsabled on the Device
            let purchaceAlert = UIAlertController(title: "Reset Level", message: "Puchase is disabled in your device", preferredStyle: UIAlertControllerStyle.alert)
            
            purchaceAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in
                print("Close")
            }))
            
            let vc = parent?.view?.window?.rootViewController
            if vc?.presentedViewController == nil {
                vc?.present(purchaceAlert, animated: true, completion: nil)
            }
        }
    }
}
