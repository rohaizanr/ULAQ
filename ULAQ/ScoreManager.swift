//
//  ScoreManager.swift
//  Ulaq
//
//  Created by Rohaizan Roosley on 02/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import UIKit
import os.log

class ScoreManager  {
    
    var score = Score()
    
    func new()->Score{
        let defaults = UserDefaults.standard
        
        var currenctScore = defaults.integer(forKey: currentScoreConstant)
        if currenctScore == 0 {
            currenctScore = 0
            defaults.set(currenctScore, forKey: currentScoreConstant)
        }
        
        var topScore = defaults.integer(forKey: topScoreConstant)
        if topScore == 0 {
            topScore = 0
            defaults.set(topScore, forKey: topScoreConstant)
        }
        
        return Score(currentScore: currenctScore, topScore: topScore)
    }
    
    
    // Initialize score file
    func saveScore(score: Score) {
        let defaults = UserDefaults.standard
        
        defaults.set(score.currentScore, forKey: currentScoreConstant)
        defaults.set(score.topScore, forKey: topScoreConstant)
    }

}
