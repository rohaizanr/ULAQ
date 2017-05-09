//
//  Level.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import Foundation

class Level {
    
    var levelNum: Int = 0
    
    var obstacleMoveDelaySec: Double = 0
    var obstacleSpawnSec: Double = 0
    var numOfObstacle: Int = 0
    
    var numOfApples: Int = 0
    
    init(){
        self.levelNum = 0
        self.numOfApples = 0
        self.numOfObstacle = 0
        self.obstacleSpawnSec = 0
        self.obstacleMoveDelaySec = 0
    }
    
    init(levelNum:Int, numOfApples:Int, numOfObstacle:Int,
         obstacleSpawnSec:Double, obstacleMoveDelaySec:Double) {
        self.levelNum = levelNum
        self.numOfApples = numOfApples
        self.numOfObstacle = numOfObstacle
        self.obstacleSpawnSec = obstacleSpawnSec
        self.obstacleMoveDelaySec = obstacleMoveDelaySec
    }
}
