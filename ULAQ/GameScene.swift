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
    
    var level = Level()
    
    var motionManager = CMMotionManager()
    var destX:CGFloat  = 0.0
    var destY:CGFloat  = 0.0
    
    var label2 = SKLabelNode()
    
    override func didMove(to view: SKView) {
        self.scaleMode = .fill
        
        self.setupLevel()
        
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
    
    func setupLevel(){
        level = LevelManager().new()
        
        if (PLAY_MODE==2) {
            level.numOfObstacle = 0
            level.numOfApples = 0
            level.levelNum = 0
        }
        
        if(level.numOfObstacle > 0){
            obstacle.parentScene = self
            
            obstacle.numOfObstacle = level.numOfObstacle
            obstacle.spawnTimer = level.obstacleSpawnSec
            obstacle.delayMoveTimer = level.obstacleMoveDelaySec
            
            obstacle.start()
        }
        
        let label1 = SKLabelNode(fontNamed: "Chalkduster")
        label1.text = "Level \(level.levelNum)"
        label1.fontSize = 30
        label1.fontColor = SKColor.black
        label1.position = CGPoint(x: 0, y: -650)
        addChild(label1)
        
        label2 = SKLabelNode(fontNamed: "Chalkduster")
        
        if(level.numOfApples>0){
            label2.text = "Apples \(level.numOfApples)"
        }else{
            label2.text = "Apples 0"
        }
        
        label2.fontSize = 30
        label2.fontColor = SKColor.black
        label2.position = CGPoint(x: -300, y: -650)
        addChild(label2)
        
        
        let label3 = SKLabelNode(fontNamed: "Chalkduster")
        label3.text = "Obstacle \(level.numOfObstacle)"
        label3.fontSize = 30
        label3.fontColor = SKColor.black
        label3.position = CGPoint(x: 280, y: -650)
        addChild(label3)
 
        apple.parentScene = self
        apple.new()
        
        snake.parentScene = self
        snake.new()
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        //Collision detection
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask) {
            
        case appleUnit | headUnit:
            currentScore += 1
            level.numOfApples -= 1
            
            
            if(level.numOfApples == 0){
                self.gameOverEvent(win: true)
            }else if(level.numOfApples > 0){
                label2.text = "Apples \(level.numOfApples)"
            }else if (level.numOfApples < 0){
                label2.text = "Apples \(currentScore)"
            }
            
            snake.eat(apple: apple)
            
        case borderUnit | headUnit:
            self.gameOverEvent(win: false)
            
        case bodyUnit | headUnit:
            self.gameOverEvent(win: false)
        
        case headUnit | obstacleUnit:
            self.gameOverEvent(win: false)
            
        default:
            return
            
        }
    }
    
    func gameOverEvent(win:Bool){
        let score = ScoreManager().new()
        
        score.currentScore = currentScore
        
        if(score.currentScore > score.topScore){
            score.topScore = score.currentScore
        }
        
        ScoreManager().saveScore(score: score)
        
        motionManager.stopAccelerometerUpdates()
        
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameOverScene = GameOver(size: self.size, won: win)
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
