//
//  Snake.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import SpriteKit


class Snake: SKSpriteNode{
    
    //0.05 expert
    //0.15 normal
    //0.25 beginner
    var snakeSpeed:Double  = 0.25
    
    var snakeHead = SKSpriteNode()
    var snakebody = SKSpriteNode()
    var snakeBodies = [SKSpriteNode]()
    
    var parentScene: SKScene?
    
    
    var headSkin:String = "Snakehead"
    var bodySkin:String = "Body1"
    
    func getSkinSettings(){
        let defaults = UserDefaults.standard
        
        var value = defaults.integer(forKey: skinConstant)
        if value == 0 {
            value = 1
            defaults.set(value, forKey: skinConstant)
        }
        
        switch value {
        case 1:
            headSkin = "Snakehead"
            bodySkin = "Body1"
        case 2:
            headSkin = "Snakehead2"
            bodySkin = "Body2"
        case 3:
            headSkin = "Snakehead3"
            bodySkin = "Body3"
        case 4:
            headSkin = "Snakehead4"
            bodySkin = "Body4"
        case 5:
            headSkin = "Snakehead5"
            bodySkin = "Body5"
        default:
            return
        }
    }
    
    func getSpeedSetting(){
        let defaults = UserDefaults.standard
        let value = defaults.integer(forKey: firstTimerConstant)
        if value == 0 {
            defaults.set(1, forKey: firstTimerConstant)
        }
        
        self.snakeSpeed = defaults.double(forKey: difficultyConstant)
    }
    
    func new(){
        self.getSkinSettings()
        
        snakeHead = SKSpriteNode(imageNamed: headSkin)
        snakeHead.position = CGPoint(x: 0,y: 0)
        snakeHead.physicsBody = SKPhysicsBody(circleOfRadius: snakeHead.size.width / 2.0)
        snakeHead.physicsBody?.affectedByGravity = false
        snakeHead.physicsBody?.usesPreciseCollisionDetection = true
        
        snakeHead.physicsBody?.isDynamic = true
        snakeHead.physicsBody?.restitution = 0
        snakeHead.physicsBody?.friction = 0
        snakeHead.physicsBody?.categoryBitMask = headUnit
        snakeHead.physicsBody?.contactTestBitMask = appleUnit | borderUnit | bodyUnit | obstacleUnit
        snakeHead.physicsBody?.collisionBitMask = appleUnit | borderUnit | bodyUnit | obstacleUnit
        
        snakeHead.run(SKAction.playSoundFileNamed("startgame.mp3",waitForCompletion:false));
        snakeBodies.append(snakeHead)
        
        parentScene?.addChild(snakeHead)
        
        for _ in 0 ..< 3 {
            self.createBody()
        }
        
        self.getSpeedSetting()
    }
    
    private func createBody(){
        snakebody = SKSpriteNode(imageNamed: bodySkin)
        
        snakebody.position = CGPoint(x: snakeBodies[snakeBodies.count-1].position.x,y: snakeBodies[snakeBodies.count-1].position.y)
        
        snakebody.physicsBody = SKPhysicsBody(circleOfRadius: snakebody.size.width / 2.0)
        snakebody.physicsBody?.affectedByGravity = false
        snakebody.physicsBody?.isDynamic = true
        snakebody.physicsBody?.restitution = 1
        snakebody.physicsBody?.friction = 0
        
        if(snakeBodies.count > 3){
            snakebody.physicsBody?.usesPreciseCollisionDetection = true
            snakebody.physicsBody?.categoryBitMask = bodyUnit
            snakebody.physicsBody?.collisionBitMask = headUnit
            snakebody.physicsBody?.contactTestBitMask = headUnit
        }
        
        snakeBodies.append(snakebody)
        
        parentScene?.addChild(snakebody)
    }
    
    func eat(apple: Apple){
        apple.remove()
        
        self.createBody()
        
        snakebody.run(SKAction.playSoundFileNamed("eat.mp3",waitForCompletion:false));
    }
}
