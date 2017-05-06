//
//  Score.swift
//  Ulaq
//
//  Created by Rohaizan Roosley on 02/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import UIKit
import os.log

class Score: NSObject, NSCoding  {
    
    struct PropertyKey {
        static let data = "data"
        static let topData = "topData"
    }
    var data: Int
    var topData: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("data")
    
    //MARK: Initialization
    init?(data: Int,topData: Int){
        self.data = data
        self.topData = topData
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(data, forKey: PropertyKey.data)
        aCoder.encode(topData, forKey: PropertyKey.topData)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let data = aDecoder.decodeInteger(forKey: PropertyKey.data)
        let topData = aDecoder.decodeInteger(forKey: PropertyKey.topData)
        self.init(data: data,topData: topData)
    }
    
    func getTopScore() -> Int {
        
        var result: Int = 0
        
        if let savedScore = loadScore() {
            result = savedScore.topData
        }
        
        return result
    }
    
    func getScore() -> Int {
        
        var result: Int = 0
        
        if let savedScore = loadScore() {
            result = savedScore.data
        }
        
        return result
    }
    
    // Initialize score file
    func saveScore(score: Score) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(score, toFile: Score.ArchiveURL.path)
        if isSuccessfulSave {
            if #available(iOS 10.0, *) {
                os_log("Score successfully saved.", log: OSLog.default, type: .debug)
            } else {
                // Fallback on earlier versions
            }
        } else {
            if #available(iOS 10.0, *) {
                os_log("To save score...", log: OSLog.default, type: .error)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private func loadScore() -> Score? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Score.ArchiveURL.path) as? Score
    }
}
