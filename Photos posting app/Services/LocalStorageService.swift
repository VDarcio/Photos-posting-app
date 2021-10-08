//
//  LocalStorageService.swift
//  CWC FireBase photos
//
//  Created by VD on 16/08/2021.
//

import Foundation



class LocalStorageService{
    
    static func saveUser(userid:String?, username:String?){
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(userid, forKey: Constants.LocalSTorage.userIDKey)
        defaults.setValue(username, forKey: Constants.LocalSTorage.usernameKey)
    }
    
    
    static func loadUser()->PhotoUser?{
        let defaults = UserDefaults.standard
      
        
        let userid = defaults.value(forKey: Constants.LocalSTorage.userIDKey) as? String
        let username = defaults.value(forKey: Constants.LocalSTorage.usernameKey) as? String
        
        if userid != nil && username != nil{
            return PhotoUser(userId: userid, username: username)
            
        }
        else{
            return nil
        }
    }
    
    static func clearUser(){
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(nil, forKey: Constants.LocalSTorage.usernameKey)
        defaults.setValue(nil, forKey: Constants.LocalSTorage.usernameKey)
    }
}
