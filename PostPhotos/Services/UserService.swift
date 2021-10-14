//
//  UserService.swift
//  CWC FireBase photos
//
//  Created by VD on 15/08/2021.
//

import Foundation
import FirebaseFirestore

class UserService{
    
    static func createProfile(userID:String, username: String, completion: @escaping(PhotoUser?)->Void){
        
        let profiledata = ["username":username]
       
        let db = Firestore.firestore()
        db.collection("users").document(userID).setData(profiledata) { error in
            if error == nil{
                
                var u = PhotoUser()
                u.username = username
                u.userId = userID
                
                
                completion(u)
                
            }
            else{
                completion(nil)
                
            }
        }
    }
    
    static func retrieveProfile(userId:String, completion: @escaping (PhotoUser?)->Void){
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { snapshot, error in
            if error != nil {
                return
            }
            
            if let profile = snapshot!.data() {
                var u = PhotoUser()
                u.userId = snapshot!.documentID
                u.username = profile["username"] as? String
                completion(u)
            }
            else{
                print(error)
                completion(nil)
            }
        }
        
        
    }
}
