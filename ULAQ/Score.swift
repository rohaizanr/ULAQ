//
//  Score.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import Foundation

class Score{
    
    var currentScore: Int
    var topScore: Int

    init() {
        self.currentScore = 0
        self.topScore = 0
    }
    
    init(currentScore: Int, topScore:Int) {
        self.currentScore = currentScore
        self.topScore = topScore
    }

}
