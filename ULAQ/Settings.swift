//
//  Settings.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import SpriteKit

class Settings:SKScene, InAppPurchaseManagerDelegate {
    
    var lvl1Btn = SKSpriteNode()
    var lvl6Btn = SKSpriteNode()
    var lvl11Btn = SKSpriteNode()
    var lvl16Btn = SKSpriteNode()
    var lvl21Btn = SKSpriteNode()
    var label = SKLabelNode()
    var label1 = SKLabelNode()
    var label2 = SKLabelNode()
    var label3 = SKLabelNode()
    
    var isPremiumVersion = UserDefaults.standard.bool(forKey: premiumPurchaseConstant)

    var purchaseManager = InAppPurchaseManager()
    
    var loadingAlert = UIAlertController()
    var okButtonAdded:Bool = false
    
    override func didMove(to view: SKView) {
        self.scaleMode = .fill
        
        label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "< Back"
        label.fontSize = 40
        label.name = "backBtn"
        label.isUserInteractionEnabled = false
        label.fontColor = SKColor.black
        label.position = CGPoint(x: -290, y: 550)
        addChild(label)
        
        
        lvl1Btn = SKSpriteNode(imageNamed: "checkNo")
        lvl1Btn.name = "lvl1Btn"
        lvl1Btn.isUserInteractionEnabled = false
        lvl1Btn.position = CGPoint(x: 280, y: 440)
        self.addChild(lvl1Btn)
        
        lvl6Btn = SKSpriteNode(imageNamed: "checkNo")
        lvl6Btn.name = "lvl6Btn"
        lvl6Btn.isUserInteractionEnabled = false
        lvl6Btn.position = CGPoint(x: 280, y: 310)
        self.addChild(lvl6Btn)
        
        lvl11Btn = SKSpriteNode(imageNamed: "checkNo")
        lvl11Btn.name = "lvl11Btn"
        lvl11Btn.isUserInteractionEnabled = false
        lvl11Btn.position = CGPoint(x: 280, y: 170)
        self.addChild(lvl11Btn)
        
        lvl16Btn = SKSpriteNode(imageNamed: "checkNo")
        lvl16Btn.name = "lvl16Btn"
        lvl16Btn.isUserInteractionEnabled = false
        lvl16Btn.position = CGPoint(x: 280, y: 28)
        self.addChild(lvl16Btn)
        
        lvl21Btn = SKSpriteNode(imageNamed: "checkNo")
        lvl21Btn.name = "lvl21Btn"
        lvl21Btn.isUserInteractionEnabled = false
        lvl21Btn.position = CGPoint(x: 280, y: -120)
        self.addChild(lvl21Btn)
        
        label2 = SKLabelNode(fontNamed: "Chalkduster")
        label2.text = "Reset Level"
        label2.fontSize = 48
        label2.name = "resetLevelBtn"
        label2.isUserInteractionEnabled = false
        label2.fontColor = SKColor.black
        label2.position = CGPoint(x: 0, y: -430)
        addChild(label2)
        
        if(!isPremiumVersion){
            label1 = SKLabelNode(fontNamed: "Chalkduster")
            label1.text = "Buy"
            label1.fontSize = 48
            label1.name = "buyBtn"
            label1.isUserInteractionEnabled = false
            label1.fontColor = SKColor.black
            label1.position = CGPoint(x: 290, y: 550)
            addChild(label1)
            
            label3 = SKLabelNode(fontNamed: "Chalkduster")
            label3.text = "Restore Purchase"
            label3.fontSize = 48
            label3.name = "restorePurchaseBtn"
            label3.isUserInteractionEnabled = false
            label3.fontColor = SKColor.black
            label3.position = CGPoint(x: 0, y: -550)
            addChild(label3)
        }
        
        self.getSkin()
        
        if(!isPremiumVersion){
            self.purchaseManager.parent = self
            self.purchaseManager.delegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            
            if node.name == "lvl1Btn"{
                resetCheckBox()
                lvl1Btn.texture = SKTexture(imageNamed: "checkYes")
                self.changeSkin(i: 1)
                label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                
            }else if node.name == "lvl6Btn"{
                label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                if(UnlockSkinManager().getUnlocks()>1){
                    resetCheckBox()
                    lvl6Btn.texture = SKTexture(imageNamed: "checkYes")
                    self.changeSkin(i: 2)
                }else{
                    self.askBuy()
                }
                
            }else if node.name == "lvl11Btn"{
                label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                if(UnlockSkinManager().getUnlocks()>2){
                    resetCheckBox()
                    lvl11Btn.texture = SKTexture(imageNamed: "checkYes")
                    self.changeSkin(i: 3)
                }else{
                    self.askBuy()
                }
                
            }else if node.name == "lvl16Btn"{
                label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                if(UnlockSkinManager().getUnlocks()>3){
                    resetCheckBox()
                    lvl16Btn.texture = SKTexture(imageNamed: "checkYes")
                    self.changeSkin(i: 4)
                }else{
                    self.askBuy()
                }
                
            }else if node.name == "lvl21Btn"{
                label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                if(UnlockSkinManager().getUnlocks()>4){
                    resetCheckBox()
                    lvl21Btn.texture = SKTexture(imageNamed: "checkYes")
                    self.changeSkin(i: 5)
                }else{
                    self.askBuy()
                }
            
            }else if node.name == "topScoreBtn"{
                
                if(UnlockSkinManager().getUnlocks()<4){
                    label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                    self.askBuy()
                }
            
            }else if node.name == "buyBtn"{
                label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                self.askBuy()
                
            }else if node.name == "resetLevelBtn"{
                label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                self.askReset()
                
            }else if node.name == "restorePurchaseBtn"{
                label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                self.purchaseManager.restorePurchase()
                
            }else if node.name == "backBtn"{
                let reveal = SKTransition.crossFade(withDuration: 0.5)
                let scene = GameScene(fileNamed: "Opening")
                scene?.scaleMode = .fill
                self.scene?.view?.presentScene(scene!, transition:reveal)
                
            }
        }
    }
    
    func askBuy(){
        
        var message = "Unable to reach App Store. Please try again later."
        
        if(!BUY_MESSAGE.isEmpty){
            message = BUY_MESSAGE
        }
        
        let refreshAlert = UIAlertController(title: "Buy Premium", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        if(!BUY_MESSAGE.isEmpty){
            refreshAlert.addAction(UIAlertAction(title: "Buy", style: .cancel, handler: { (action: UIAlertAction!) in
                self.purchaseManager.buyPremium()
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                print("Cancelled")
            }))
        }else{
            refreshAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in
                print("Cancelled")
            }))
        }
        
        let vc = self.view?.window?.rootViewController
        if vc?.presentedViewController == nil {
            vc?.present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    func askReset(){
        let refreshAlert = UIAlertController(title: "Reset Level", message: "This will restart the game back the Level 1. Your unlocks will not be reset.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { (action: UIAlertAction!) in
            LevelManager().resetLevel()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            print("Cancelled")
        }))
        
        let vc = self.view?.window?.rootViewController
        if vc?.presentedViewController == nil {
            vc?.present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    func resetCheckBox(){
        switch UnlockSkinManager().getUnlocks() {
        case 1:
            return
        case 2:
            lvl1Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl6Btn.texture = SKTexture(imageNamed: "checkNo")
        case 3:
            lvl1Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl6Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl11Btn.texture = SKTexture(imageNamed: "checkNo")
        case 4:
            lvl1Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl6Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl11Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl16Btn.texture = SKTexture(imageNamed: "checkNo")
        case 5:
            lvl1Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl6Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl11Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl16Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl21Btn.texture = SKTexture(imageNamed: "checkNo")
        case 6:
            lvl1Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl6Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl11Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl16Btn.texture = SKTexture(imageNamed: "checkNo")
            lvl21Btn.texture = SKTexture(imageNamed: "checkNo")
        default:
            return
        }
    }
    
    func changeSkin(i:Int){
        let defaults = UserDefaults.standard
        defaults.set(i, forKey: skinConstant)
    }
    
    func getSkin(){
        let defaults = UserDefaults.standard
        
        var value = defaults.integer(forKey: skinConstant)
        if value == 0 {
            value = 1
            defaults.set(value, forKey: skinConstant)
        }
        
        switch value {
        case 1:
            lvl1Btn.texture = SKTexture(imageNamed: "checkYes")
        case 2:
            lvl6Btn.texture = SKTexture(imageNamed: "checkYes")
        case 3:
            lvl11Btn.texture = SKTexture(imageNamed: "checkYes")
        case 4:
            lvl16Btn.texture = SKTexture(imageNamed: "checkYes")
        case 5:
            lvl21Btn.texture = SKTexture(imageNamed: "checkYes")
        default:
            return
        }
        
        switch UnlockSkinManager().getUnlocks() {
        case 1:
            lvl6Btn.texture = SKTexture(imageNamed: "checkLock")
            lvl11Btn.texture = SKTexture(imageNamed: "checkLock")
            lvl16Btn.texture = SKTexture(imageNamed: "checkLock")
            lvl21Btn.texture = SKTexture(imageNamed: "checkLock")
        case 2:
            lvl11Btn.texture = SKTexture(imageNamed: "checkLock")
            lvl16Btn.texture = SKTexture(imageNamed: "checkLock")
            lvl21Btn.texture = SKTexture(imageNamed: "checkLock")
        case 3:
            lvl16Btn.texture = SKTexture(imageNamed: "checkLock")
            lvl21Btn.texture = SKTexture(imageNamed: "checkLock")
        case 4:
            lvl21Btn.texture = SKTexture(imageNamed: "checkLock")
        default:
            return
        }
    }
    
    func didFinishTask(sender: InAppPurchaseManager) {
        self.resetCheckBox()
        self.getSkin()
        
        label1.removeFromParent()
        label3.removeFromParent()
    }
    
    func transactionInProgress(sender: InAppPurchaseManager) {
        self.showLoading()
    }
    
    func transactionCompleted(sender: InAppPurchaseManager) {
        let title  = sender.transactionTitle
        let message  = sender.transactionMsg
        
        var titleStr = NSMutableAttributedString()
        titleStr = NSMutableAttributedString(string: title as String)
        
        loadingAlert.setValue(titleStr, forKey: "attributedTitle")
        
        var titleMsg = NSMutableAttributedString()
        titleMsg = NSMutableAttributedString(string: message as String)
        
        loadingAlert.setValue(titleMsg, forKey: "attributedMessage")
        
        if(!okButtonAdded){
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            loadingAlert.addAction(action)
            
            okButtonAdded = true
        }
    }
    
    func showLoading(){
        okButtonAdded = false
        
        loadingAlert = UIAlertController(title: "App Store", message: "Connecting to App Store..", preferredStyle: UIAlertControllerStyle.alert)
        
        let vc = self.view?.window?.rootViewController
        if vc?.presentedViewController == nil {
            vc?.present(loadingAlert, animated: true, completion: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
