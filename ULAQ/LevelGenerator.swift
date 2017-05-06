//
//  LevelGenerator.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import Foundation

class LevelGenerator {
    
    var levelNum: Int = 0
    
    var obstacleSpawnSec: Int = 0
    var numOfObstacle: Int = 0
    var numOfApples: Int = 0
    
    func new(){
        
        // currentLevelConstant
        let defaults = UserDefaults.standard
        let value = defaults.integer(forKey: currentLevelConstant)
        if value == 0 {
            defaults.set(1, forKey: currentLevelConstant)
        }
        
        self.levelNum = defaults.integer(forKey: currentLevelConstant)
        
        
    }
    
    func generateLevelRules(){
        if ( self.levelNum < 6){
            self.numOfApples = 5 + self.levelNum
            
        }else if ( self.levelNum < 11){
            self.numOfApples = 5 + self.levelNum
            
        }else if ( self.levelNum < 16){
            self.numOfApples = 10 + self.levelNum
            
        }else if ( self.levelNum < 21){
            self.numOfApples = 10 + self.levelNum
            
        }else if ( self.levelNum < 26){
            self.numOfApples = 15 + self.levelNum
            
        }else if ( self.levelNum < 31){
            self.numOfApples = 15 + self.levelNum
            
        }else if ( self.levelNum < 36){
            self.numOfApples = 20 + self.levelNum
            
        }else if ( self.levelNum < 41){
            self.numOfApples = 20 + self.levelNum
            
        }else if ( self.levelNum > 95){
            self.numOfApples = 55 + self.levelNum
            
        }
        
        
    }
}
