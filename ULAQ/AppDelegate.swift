//
//  AppDelegate.swift
//  Ulaq
//
//  Created by Rohaizan Roosley on 30/04/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var scores = [Score]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // do appOptions checking here
        if let savedScore = loadScore() {
            scores.append(savedScore)
        }else{
            let score = Score(data: 0, topData: 0)
            scores.append(score!)
            saveScore()
        }
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Initialize score file
    private func saveScore() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(scores[0], toFile: Score.ArchiveURL.path)
        if isSuccessfulSave {
            //os_log("Score successfully saved.", log: OSLog.default, type: .debug)
        } else {
            //os_log("To save score...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadScore() -> Score? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Score.ArchiveURL.path) as? Score
    }
}

