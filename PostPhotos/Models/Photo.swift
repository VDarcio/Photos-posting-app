//
//  Photo.swift
//  CWC FireBase photos
//
//  Created by VD on 17/08/2021.
//
import  FirebaseFirestore
import Foundation

struct Photo {
    var photoID:String?
    var url: String?
    var byiD: String?
    var byUsername:String?
    var date:String?
    
    init?(snapchot:QueryDocumentSnapshot) {
        
       let data = snapchot.data()
        
        let photoID = data["photoID"] as? String
        let userId = data["byiD"] as? String
        let username = data["byUsername"] as? String
        let date = data["date"] as? String
        let url = data ["url"] as? String
        
        self.photoID = photoID
        self.byiD = userId
        self.byUsername = username
        self.date = date
        self.url = url
         
        
    }
    
    
}
