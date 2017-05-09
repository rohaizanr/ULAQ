//
//  UnlockSkinManager.swift
//  ULAQ
//
//  Created by Rohaizan Roosley on 07/05/2017.
//  Copyright © 2017 Rohaizan Roosley. All rights reserved.
//

import Foundation


class UnlockSkinManager{
    
    
    func getUnlocks()->Int{
        let defaults = UserDefaults.standard
        
        var value = defaults.integer(forKey: unlockConstant)
        if value == 0 {
            value = 1
            defaults.set(value, forKey: unlockConstant)
        }
        return value
    }

    func increamentUnlock(){
        
        if(self.getUnlocks() > 5){
            
        }else{
            let defaults = UserDefaults.standard
            var value = defaults.integer(forKey: unlockConstant)
            value += 1
            defaults.set(value, forKey: unlockConstant)
        }
    }
}
