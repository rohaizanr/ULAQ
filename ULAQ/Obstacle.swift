//
//  Obstacle.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import SpriteKit

class Obstacle: SKSpriteNode {
    
    var timer = Timer()
    
    var parentScene: SKScene?
    
    var obstacle = SKSpriteNode()
    
    func new(){
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.generateRandomObstacle), userInfo: nil, repeats: true)
    }
    
    func generate(){
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
        
        obstacle = SKSpriteNode(imageNamed: "Obstacle")
        
        obstacle.position = CGPoint(x: randX,y: randY)
        obstacle.physicsBody = SKPhysicsBody(circleOfRadius: obstacle.size.width / 2.0)
        obstacle.physicsBody?.affectedByGravity = false
        
        obstacle.physicsBody?.usesPreciseCollisionDetection = true
        obstacle.physicsBody?.isDynamic = true
        
        obstacle.physicsBody?.collisionBitMask = headUnit | borderUnit
        obstacle.physicsBody?.categoryBitMask = obstacleUnit
        obstacle.physicsBody?.contactTestBitMask = headUnit
        
        obstacle.physicsBody?.restitution = 1
        obstacle.physicsBody?.linearDamping = 0
        obstacle.physicsBody?.velocity = CGVector(dx: -500, dy: 500)
        
        parentScene?.addChild(obstacle)
    }
    
    func remove(){
        obstacle.removeFromParent()
    }
    
    
    func generateRandomObstacle(){
        self.generate()
        
        timer.invalidate()
    }
}
