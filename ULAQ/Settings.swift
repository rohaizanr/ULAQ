//
//  Settings.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import SpriteKit

class Settings:SKScene {
    
    var lvl1Btn = SKSpriteNode()
    var lvl6Btn = SKSpriteNode()
    var lvl11Btn = SKSpriteNode()
    var lvl16Btn = SKSpriteNode()
    var lvl21Btn = SKSpriteNode()
    var label = SKLabelNode()
    
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
        
        
        self.getSkin()
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
                if(UnlockSkinManager().getUnlocks()>1){
                    resetCheckBox()
                    lvl6Btn.texture = SKTexture(imageNamed: "checkYes")
                    self.changeSkin(i: 2)
                    label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                }
                
            }else if node.name == "lvl11Btn"{
                if(UnlockSkinManager().getUnlocks()>2){
                    resetCheckBox()
                    lvl11Btn.texture = SKTexture(imageNamed: "checkYes")
                    self.changeSkin(i: 3)
                    label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                }
                
            }else if node.name == "lvl16Btn"{
                if(UnlockSkinManager().getUnlocks()>3){
                    resetCheckBox()
                    lvl16Btn.texture = SKTexture(imageNamed: "checkYes")
                    self.changeSkin(i: 4)
                    label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                }
                
            }else if node.name == "lvl21Btn"{
                if(UnlockSkinManager().getUnlocks()>4){
                    resetCheckBox()
                    lvl21Btn.texture = SKTexture(imageNamed: "checkYes")
                    self.changeSkin(i: 5)
                    label.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                }
                
            }else if node.name == "backBtn"{
                let reveal = SKTransition.crossFade(withDuration: 0.5)
                let scene = GameScene(fileNamed: "Opening")
                scene?.scaleMode = .fill
                self.scene?.view?.presentScene(scene!, transition:reveal)
                
            }
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
