//
//  Obstacle.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import SpriteKit

class Obstacle: SKSpriteNode {
    
    var currentObstacle:Int = 0
    
    var numOfObstacle:Int = 0
    
    var spawnTimer:Double = 5
    var timer = Timer()
    
    var delay = Timer()
    var delayMoveTimer:Double = 10
    
    var parentScene: SKScene?
    
    var obstacle = SKSpriteNode()
        
    func start(){
        timer = Timer.scheduledTimer(timeInterval: spawnTimer, target: self, selector: #selector(self.generateRandomObstacle), userInfo: nil, repeats: true)
        
        self.currentObstacle = self.numOfObstacle
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
        
        parentScene?.addChild(obstacle)
        
        delay = Timer.scheduledTimer(timeInterval: delayMoveTimer, target: self, selector: #selector(self.moveObstacle), userInfo: nil, repeats: true)
    }
    
    
    func moveObstacle(){
        //obstacle.physicsBody?.velocity = CGVector(dx: -250, dy: 250)
        obstacle.physicsBody?.applyImpulse(CGVector(dx: 25, dy: 25))
        
        delay.invalidate()
        
        self.currentObstacle -= 1
        
        if(self.currentObstacle>0){
            timer = Timer.scheduledTimer(timeInterval: spawnTimer, target: self, selector: #selector(self.generateRandomObstacle), userInfo: nil, repeats: true)
        }
    }
    
    
    func remove(){
        obstacle.removeFromParent()
    }
    
    func generateRandomObstacle(){
        self.generate()
        
        timer.invalidate()
    }
}
