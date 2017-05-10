//
//  LevelManager.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import Foundation

class LevelManager {
    
    var levelNum: Int = 0
    
    func new() -> Level{
        let defaults = UserDefaults.standard
        let value = defaults.integer(forKey: currentLevelConstant)
        if value == 0 {
            defaults.set(1, forKey: currentLevelConstant)
        }
        
        self.levelNum = defaults.integer(forKey: currentLevelConstant)
        
        return self.generateLevel()
    }
    
    private func generateLevel()->Level{
        if (self.levelNum < 6){
            return Level(levelNum: self.levelNum, numOfApples: self.levelNum + 5, numOfObstacle: 1, obstacleSpawnSec: 10, obstacleMoveDelaySec: 20)
            
        }else if (self.levelNum < 11){
            return Level(levelNum: self.levelNum, numOfApples: self.levelNum + 5, numOfObstacle: 2, obstacleSpawnSec: 5, obstacleMoveDelaySec: 10)
            
        }else if (self.levelNum < 16){
            return Level(levelNum: self.levelNum, numOfApples: self.levelNum + 5, numOfObstacle: 3, obstacleSpawnSec: 5, obstacleMoveDelaySec: 5)
            
        }else if (self.levelNum == 20){
            return Level(levelNum: self.levelNum, numOfApples: self.levelNum + 5, numOfObstacle: 4, obstacleSpawnSec: 3, obstacleMoveDelaySec: 3)
        }else {
            return Level(levelNum: self.levelNum, numOfApples: -1, numOfObstacle: 0, obstacleSpawnSec: 0, obstacleMoveDelaySec: 0)
        }
    }
    
    func incrementLevel(){
        
        if (PLAY_MODE==1) {
            let defaults = UserDefaults.standard
            var value = defaults.integer(forKey: currentLevelConstant)
            value += 1
            defaults.set(value, forKey: currentLevelConstant)
            
            if (value == 6 || value == 11 || value == 16 || value == 21){
                UnlockSkinManager().increamentUnlock()
            }
        }
        
    }
    
    func resetLevel(){
        let defaults = UserDefaults.standard
        defaults.set(1, forKey: currentLevelConstant)
    }
}
