//
//  Apple.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import SpriteKit

class Apple: SKSpriteNode {
    
    var timer = Timer()
    
    var parentScene: SKScene?
    
    var apple = SKSpriteNode()
    
    func new(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.generateRandomApple), userInfo: nil, repeats: true)
    }
    
    func generate(){
        apple = SKSpriteNode(imageNamed: "Apple")
        
        var randX: Double = Double(arc4random_uniform(300) + 1)
        var randY: Double = Double(arc4random_uniform(300) + 1)
        
        let checkpositive1 = arc4random()
        let checkpositive2 = arc4random()
        
        if(checkpositive1%2==0){
            randX = -abs(randX)
        }
        if(checkpositive2%2==0){
            randY = -abs(randY)
        }
        
        apple.position = CGPoint(x: randX,y: randY)
        apple.physicsBody = SKPhysicsBody(circleOfRadius: apple.size.width / 2.0)
        apple.physicsBody?.affectedByGravity = false
        
        apple.physicsBody?.usesPreciseCollisionDetection = true
        apple.physicsBody?.isDynamic = true
        
        apple.physicsBody?.categoryBitMask = appleUnit
        apple.physicsBody?.collisionBitMask = headUnit
        apple.physicsBody?.contactTestBitMask = headUnit
        
        parentScene?.addChild(apple)
    }
    
    func remove(){
        apple.removeFromParent()
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.generateRandomApple), userInfo: nil, repeats: true)
    }
    
    
    func generateRandomApple(){
        self.generate()
        
        timer.invalidate()
    }
}
