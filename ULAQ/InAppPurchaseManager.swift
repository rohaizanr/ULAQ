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
    
    var transactionTitle = ""
    var transactionMsg = ""
    
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
        
        if (queue.transactions.count < 1){
            
            self.showDialog(title: "Restore Purchase Failed!", message: "You have not made any purchase.")
        }
        
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
            case PREMIUM_PROD_ID:
                
                UnlockSkinManager().buyPremium()
                
                self.showDialog(title: "Restore Purchase Successful!", message: "You have successfully restored your purchase.")
                
                delegate?.didFinishTask(sender: self)
                
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                
                self.showDialog(title: "Restore Purchase Failed!", message: "You have not made any purchase.")
                
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
        
        delegate?.transactionCompleted(sender: self)
    }
    
    // MARK: - RESTORE ERROR
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        
        self.showDialog(title: "Restore Purchase Failed!", message: "You have not made any purchase.")
        
        delegate?.transactionCompleted(sender: self)
    }

    // MARK: - REQUEST IAP PRODUCTS
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if (response.products.count > 0) {
            iapProducts = response.products
        }
        
        delegate?.transactionCompleted(sender: self)
    }
    
    // MARK:- IAP PAYMENT QUEUE
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                    
                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    
                    if productID == PREMIUM_PROD_ID {
                        UnlockSkinManager().buyPremium()
                        
                        self.showDialog(title: "Purchase Successful!", message: "Thank you for buying. All skins has been unlocked. Top Score mode is now available in the front screen. Hope you will enjoy the game. ")
                        
                        delegate?.didFinishTask(sender: self)
                    }
                    
                    break
                    
                case .failed:
                    
                    self.showDialog(title: "Restore Purchase Failed!", message: "You have not made any purchase.")
                    
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .restored:
                    
                    self.showDialog(title: "Restore Purchase Successful!", message: "You have successfully restored your purchase.")
                    
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                default: break
                }
            }
        }
        
        delegate?.transactionCompleted(sender: self)
    }
    
    // MARK: - MAKE PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    func purchaseMyProduct(product: SKProduct) {
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            print("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
        } else {
            // IAP Purchases dsabled on the Device
            
            self.showDialog(title: "Purchase Error", message: "Purchase is disabled in your device")
        }
        
        delegate?.transactionCompleted(sender: self)
    }
    
    //MARK: Private functions
    private func showDialog(title:String, message:String){
        
        self.transactionTitle = title
        self.transactionMsg = message
        
        delegate?.transactionCompleted(sender: self)
    }
}
