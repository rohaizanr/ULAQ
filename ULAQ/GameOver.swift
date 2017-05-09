//
//  GameOver.swift
//  Ulaq
//
//  Created by Rohaizan Roosley on 01/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//


import SpriteKit

class GameOver:SKScene {
    
    init(size: CGSize, won:Bool) {
        super.init(size: size)
        // 2
        let message = won ? "You Won!" : "Game Over!"
        
        // 3
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.red
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        
        
        
        let score = ScoreManager().new()
        let currentScore = score.currentScore
        
        let label3 = SKLabelNode(fontNamed: "Chalkduster")
        label3.text = "Score: \(currentScore)"
        label3.fontSize = 40
        label3.fontColor = SKColor.red
        label3.position = CGPoint(x: size.width/2, y: (size.height/2)-100)
        addChild(label3)

        
        if(won){
            label.run(SKAction.playSoundFileNamed("win.mp3",waitForCompletion:false));
            label.fontColor = SKColor.green
            label3.fontColor = SKColor.green
            
            LevelManager().incrementLevel()
            
        }else{
            label.run(SKAction.playSoundFileNamed("gameover.mp3",waitForCompletion:false));
            
            label.fontColor = SKColor.red
            label3.fontColor = SKColor.red
        }
        
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.run() {
                // 5
                let reveal = SKTransition.crossFade(withDuration: 0.5)
                let scene = GameScene(fileNamed: "Opening")
                scene?.scaleMode = .fill
                self.scene?.view?.presentScene(scene!, transition:reveal)
            }
            ]))
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
