//
//  GameViewController.swift
//  Ulaq
//
//  Created by Rohaizan Roosley on 30/04/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import StoreKit

class GameViewController: UIViewController,SKProductsRequestDelegate  {
    
    static let speed: Double = 10
    
    var productID = ""
    var productsRequest = SKProductsRequest()
    var iapProducts = [SKProduct]()
    var isPremiumVersion = UserDefaults.standard.bool(forKey: premiumPurchaseConstant)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "Opening") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
        
        if(!isPremiumVersion){
            fetchAvailableProducts()
        }
    }
    
    func fetchAvailableProducts()  {
        // Put here your IAP Products ID's
        let productIdentifiers = NSSet(objects:PREMIUM_PROD_ID)
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    // MARK: - REQUEST IAP PRODUCTS
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if (response.products.count > 0) {
            iapProducts = response.products
            
            // 1st IAP Product (Consumable) ------------------------------------
            let firstProduct = response.products[0] as SKProduct
            
            // Get its price from iTunes Connect
            let numberFormatter = NumberFormatter()
            numberFormatter.formatterBehavior = .behavior10_4
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = firstProduct.priceLocale
            let price1Str = numberFormatter.string(from: firstProduct.price)
            
            BUY_MESSAGE = firstProduct.localizedDescription + " for just \(price1Str!)"
        }
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
