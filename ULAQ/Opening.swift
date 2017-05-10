//
//  Opening.swift
//  Ulaq
//
//  Created by Rohaizan Roosley on 02/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//


import AVFoundation
import SpriteKit

class Opening:SKScene {
    let label2 = SKLabelNode(fontNamed: "Chalkduster")
    let label5 = SKLabelNode(fontNamed: "Chalkduster")
    
    var openingEffect: AVAudioPlayer!
    
    override func didMove(to view: SKView) {
        self.scaleMode = .fill
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        let path = Bundle.main.path(forResource: "opening.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            openingEffect = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
        
        // 3
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "ULAQ"
        label.fontSize = 100
        label.fontColor = SKColor.black
        label.position = CGPoint(x: 0, y: 400)
        addChild(label)
        
        let label1 = SKLabelNode(fontNamed: "Chalkduster")
        label1.text = "Play"
        label1.name = "playButton"
        label1.isUserInteractionEnabled = false
        label1.fontSize = 70
        label1.fontColor = SKColor.black
        label1.position = CGPoint(x: 0, y: 100)
        addChild(label1)
        
        
        self.getLevelSetting()
        label2.fontSize = 50
        label2.fontColor = SKColor.black
        label2.position = CGPoint(x: 0, y: -250)
        addChild(label2)
        
        let settingButton = SKSpriteNode(imageNamed: "settingButton")
        settingButton.name = "settingButton"
        settingButton.isUserInteractionEnabled = false
        settingButton.position = CGPoint(x: -100, y: -350)
        self.addChild(settingButton)
        
        let questionButton = SKSpriteNode(imageNamed: "questionButton")
        questionButton.name = "questionButton"
        questionButton.isUserInteractionEnabled = false
        questionButton.position = CGPoint(x: 100, y: -350)
        self.addChild(questionButton)
        
        let leftButton = SKSpriteNode(imageNamed: "leftButton")
        leftButton.name = "leftButton"
        leftButton.isUserInteractionEnabled = false
        leftButton.position = CGPoint(x: -300, y: -240)
        self.addChild(leftButton)
        
        let rightButton = SKSpriteNode(imageNamed: "rightButton")
        rightButton.name = "rightButton"
        rightButton.isUserInteractionEnabled = false
        rightButton.position = CGPoint(x: 300, y: -240)
        self.addChild(rightButton)
        
        
        let scoreObj = ScoreManager().new()
        
        let topScore = scoreObj.topScore
        
        let label3 = SKLabelNode(fontNamed: "Chalkduster")
        label3.text = "Top score: \(topScore)"
        label3.fontSize = 40
        label3.fontColor = SKColor.black
        label3.position = CGPoint(x: 0, y: -500)
        addChild(label3)
        
        let level = LevelManager().new()
        
        let label4 = SKLabelNode(fontNamed: "Chalkduster")
        label4.text = "Level: \(level.levelNum)"
        label4.fontSize = 40
        label4.fontColor = SKColor.black
        label4.position = CGPoint(x: 0, y: -450)
        addChild(label4)
        
        
        if(UnlockSkinManager().getUnlocks() > 4){
            let label5 = SKLabelNode(fontNamed: "Chalkduster")
            label5.text = "Top Score Mode"
            label5.fontSize = 40
            label5.fontColor = SKColor.black
            label5.position = CGPoint(x: 0, y: -100)
            addChild(label5)
            
            let leftButton2 = SKSpriteNode(imageNamed: "leftButton")
            leftButton2.name = "leftButton2"
            leftButton2.isUserInteractionEnabled = false
            leftButton2.position = CGPoint(x: -300, y: -90)
            self.addChild(leftButton2)
            
            let rightButton2 = SKSpriteNode(imageNamed: "rightButton")
            rightButton2.name = "rightButton2"
            rightButton2.isUserInteractionEnabled = false
            rightButton2.position = CGPoint(x: 300, y: -90)
            self.addChild(rightButton2)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            
            if node.name == "playButton" {
                
                label2.run(SKAction.playSoundFileNamed("playButton.mp3",waitForCompletion:false));
                
                let defaults = UserDefaults.standard
                let value = defaults.integer(forKey: firstTimerConstant)
                if value == 0 {
                    let reveal = SKTransition.crossFade(withDuration: 0.5)
                    let scene = GameScene(fileNamed: "HowTo")
                    scene?.scaleMode = .aspectFill
                    self.scene?.view?.presentScene(scene!, transition:reveal)
                }else{
                    let reveal = SKTransition.crossFade(withDuration: 0.5)
                    let scene = GameScene(fileNamed: "GameScene")
                    scene?.scaleMode = .aspectFill
                    self.scene?.view?.presentScene(scene!, transition:reveal)
                }
                
            }else if node.name == "settingButton" {
                
                label2.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                
                let reveal = SKTransition.crossFade(withDuration: 0.5)
                let scene = GameScene(fileNamed: "Settings")
                scene?.scaleMode = .aspectFill
                self.scene?.view?.presentScene(scene!, transition:reveal)
                
            }else if node.name == "questionButton" {
                
                let defaults = UserDefaults.standard
                defaults.set(1, forKey: firstTimerConstant)
                
                label2.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                
                let reveal = SKTransition.crossFade(withDuration: 0.5)
                let scene = GameScene(fileNamed: "HowTo")
                scene?.scaleMode = .aspectFill
                self.scene?.view?.presentScene(scene!, transition:reveal)
                
                
            }else if node.name == "leftButton" {
                
                self.changeLevelText(i: 1)
                label2.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                
            }else if node.name == "rightButton" {
                
                self.changeLevelText(i: -1)
                label2.run(SKAction.playSoundFileNamed("button.mp3",waitForCompletion:false));
                
            }
        }
    }
    
    func getLevelSetting(){
        let defaults = UserDefaults.standard
        let value = defaults.double(forKey: difficultyConstant)
        if value > 0 {
            switch value {
            case 0.05:
                label2.text = "Expert"
            case 0.15:
                label2.text = "Normal"
            case 0.25:
                label2.text = "Easy"
            default:
                return
            }
        }else{
            defaults.set(0.25, forKey: difficultyConstant)
            label2.text = "Easy"
        }
    }
    
    func changeLevelText(i:Int){
        
        let defaults = UserDefaults.standard
        
        let value = defaults.double(forKey: difficultyConstant)
        
        if value > 0 {
            switch value {
            case 0.05:
                if(i>0){
                    defaults.set(0.15, forKey: difficultyConstant)
                    label2.text = "Normal"
                }else{
                    defaults.set(0.25, forKey: difficultyConstant)
                    label2.text = "Easy"
                }
            case 0.15:
                if(i>0){
                    defaults.set(0.25, forKey: difficultyConstant)
                    label2.text = "Easy"
                }else{
                    defaults.set(0.05, forKey: difficultyConstant)
                    label2.text = "Expert"
                }
            case 0.25:
                if(i>0){
                    defaults.set(0.05, forKey: difficultyConstant)
                    label2.text = "Expert"
                }else{
                    defaults.set(0.15, forKey: difficultyConstant)
                    label2.text = "Normal"
                }
            default:
                return
            }
        }else{
            defaults.set(0.25, forKey: difficultyConstant)
            label2.text = "Easy"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
