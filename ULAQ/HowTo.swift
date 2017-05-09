//
//  HowTo.swift
//  Ulaq
//
//  Created by Rohaizan Roosley on 03/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import SpriteKit

class HowTo:SKScene {
    
    var timer = Timer()
    
    var i:Int = 0
    
    var phone = SKSpriteNode()
    var howto = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.scaleMode = .fill
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "How To Play"
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: 0, y: 500)
        addChild(label)
        
        phone = SKSpriteNode(imageNamed: "phone1")
        phone.position = CGPoint(x: 0,y: 380)
        
        let label2 = SKLabelNode(fontNamed: "Chalkduster")
        label2.text = "1. Move the snake"
        label2.fontSize = 30
        label2.fontColor = SKColor.black
        label2.position = CGPoint(x: 0, y: 250)
        addChild(label2)
        
        let label3 = SKLabelNode(fontNamed: "Chalkduster")
        label3.text = " by tilting your phone."
        label3.fontSize = 30
        label3.fontColor = SKColor.black
        label3.position = CGPoint(x: 0, y: 200)
        addChild(label3)
        
        let label10 = SKLabelNode(fontNamed: "Chalkduster")
        label10.text = " (The more you tilt, the faster it moves)"
        label10.fontSize = 25
        label10.fontColor = SKColor.red
        label10.position = CGPoint(x: 0, y: 150)
        addChild(label10)
        
        let label4 = SKLabelNode(fontNamed: "Chalkduster")
        label4.text = "2. Collect as many"
        label4.fontSize = 30
        label4.fontColor = SKColor.black
        label4.position = CGPoint(x: 0, y: 60)
        addChild(label4)
        
        let label5 = SKLabelNode(fontNamed: "Chalkduster")
        label5.text = " apples as you can."
        label5.fontSize = 30
        label5.fontColor = SKColor.black
        label5.position = CGPoint(x: 0, y: 10)
        addChild(label5)
        
        let label6 = SKLabelNode(fontNamed: "Chalkduster")
        label6.text = "3. Avoid hitting the"
        label6.fontSize = 30
        label6.fontColor = SKColor.black
        label6.position = CGPoint(x: 0, y: -100)
        addChild(label6)
        
        let label7 = SKLabelNode(fontNamed: "Chalkduster")
        label7.text = " the snake's body."
        label7.fontSize = 30
        label7.fontColor = SKColor.black
        label7.position = CGPoint(x: 0, y: -150)
        addChild(label7)
        
        let label8 = SKLabelNode(fontNamed: "Chalkduster")
        label8.text = "4. Avoid hitting the"
        label8.fontSize = 30
        label8.fontColor = SKColor.black
        label8.position = CGPoint(x: 0, y: -280)
        addChild(label8)
        
        let label9 = SKLabelNode(fontNamed: "Chalkduster")
        label9.text = " screen border."
        label9.fontSize = 30
        label9.fontColor = SKColor.black
        label9.position = CGPoint(x: 0, y: -320)
        addChild(label9)
        
        let label16 = SKLabelNode(fontNamed: "Chalkduster")
        label16.text = "- tap to continue -"
        label16.fontSize = 40
        label16.fontColor = SKColor.black
        label16.position = CGPoint(x: 0, y: -450)
        addChild(label16)
        
        
        addChild(phone)
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.animatePhone), userInfo: nil, repeats: true)
    }
    
    
    func animatePhone(){
        switch i {
        case 0:
            phone.texture = SKTexture(imageNamed: "phone2")
            i+=1
            break
        case 1:
            phone.texture = SKTexture(imageNamed: "phone1")
            i+=1
            break
        case 2:
            phone.texture = SKTexture(imageNamed: "phone3")
            i+=1
            break
        case 3:
            phone.texture = SKTexture(imageNamed: "phone1")
            i+=1
            break
        case 4:
            phone.texture = SKTexture(imageNamed: "phone4")
            i+=1
            break
        case 5:
            phone.texture = SKTexture(imageNamed: "phone1")
            i+=1
            break
        case 6:
            phone.texture = SKTexture(imageNamed: "phone5")
            i+=1
            break
        case 7:
            phone.texture = SKTexture(imageNamed: "phone1")
            i=0
            break
        default: return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let defaults = UserDefaults.standard
        let value = defaults.integer(forKey: firstTimerConstant)
        
        if value == 0 {
            let reveal = SKTransition.crossFade(withDuration: 0.5)
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFill
            self.scene?.view?.presentScene(scene!, transition:reveal)
        }else{
            let reveal = SKTransition.crossFade(withDuration: 0.5)
            let scene = GameScene(fileNamed: "Opening")
            scene?.scaleMode = .aspectFill
            self.scene?.view?.presentScene(scene!, transition:reveal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
