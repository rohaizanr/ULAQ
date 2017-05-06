//
//  GameScene.swift
//  Ulaq
//
//  Created by Rohaizan Roosley on 30/04/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {

    var currentScore: Int = 0
    
    var timerObstacle = Timer()
    
    var apple = Apple()
    var obstacle = Obstacle()
    var snake = Snake()

    var motionManager = CMMotionManager()
    var destX:CGFloat  = 0.0
    var destY:CGFloat  = 0.0
    
    override func didMove(to view: SKView) {
        snake.parentScene = self
        snake.new()
        
        apple.parentScene = self
        apple.new()
        
        obstacle.parentScene = self
        obstacle.new()
        
        self.physicsWorld.contactDelegate = self
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        border.linearDamping = 0
        border.categoryBitMask = borderUnit
        border.contactTestBitMask = headUnit | obstacleUnit
        border.collisionBitMask = headUnit | obstacleUnit
        self.physicsBody = border
        
        if motionManager.isAccelerometerAvailable == true {
            
            let queue = OperationQueue()
            
            motionManager.startAccelerometerUpdates(to: queue, withHandler:{
                data, error in
                
                var accel: CMAcceleration
                
                accel = (data?.acceleration)!
                let currentX = self.snake.snakeHead.position.x
                let currentY = self.snake.snakeHead.position.y
                
                if(accel.x < 0){
                    self.destX = currentX + CGFloat(accel.x * 200)
                }else if(accel.x > 0){
                    self.destX = currentX + CGFloat(accel.x * 200)
                }
                
                if(accel.y < 0){
                    self.destY = currentY + CGFloat(accel.y * 200)
                }else if(accel.y > 0){
                    self.destY = currentY + CGFloat(accel.y * 200)
                }
            })
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //Collision detection
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask) {
            
        case appleUnit | headUnit:
            currentScore += 1
            
            snake.eat(apple: apple)
            
        case borderUnit | headUnit:
            self.gameOverEvent()
            
        case bodyUnit | headUnit:
            self.gameOverEvent()
        
        case headUnit | obstacleUnit:
            self.gameOverEvent()
            
        default:
            return
            
        }
    }
    
    func gameOverEvent(){
        let score = Score(data: currentScore, topData: 0)!
        
        score.data = currentScore
        score.topData =  score.getTopScore()
        
        if(score.data > score.topData){
            score.topData = score.data
        }
        score.saveScore(score: score)
        
        motionManager.stopAccelerometerUpdates()
        
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameOverScene = GameOver(size: self.size, won: false)
        self.scene?.view?.presentScene(gameOverScene, transition: reveal)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        var index:Int=0
        for body in snake.snakeBodies {
            var action1 = SKAction()
            var action2 = SKAction()
            var v1 = CGVector()
            var v2 = CGVector()
            var angle: CGFloat
            
            if(index==0){
                action1 = SKAction.moveTo(x: destX, duration: snake.snakeSpeed)
                action2 = SKAction.moveTo(y: destY, duration: snake.snakeSpeed)
                v1 = CGVector(dx:0, dy:1)
                v2 = CGVector(dx:destX - snake.snakeHead.position.x, dy: destY - snake.snakeHead.position.y)
                
                angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
                
            }else{
                action1 = SKAction.moveTo(x: snake.snakeBodies[index-1].position.x, duration: snake.snakeSpeed)
                action2 = SKAction.moveTo(y: snake.snakeBodies[index-1].position.y, duration: snake.snakeSpeed)
                v1 = CGVector(dx:0, dy:1)
                v2 = CGVector(dx:snake.snakeBodies[index-1].position.x - body.position.x, dy: snake.snakeBodies[index-1].position.y - body.position.y)
                
                angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
            }
            
            body.zRotation = angle
            body.run(action1)
            body.run(action2)
            
            index+=1
        }
    }
}
