//
//  PhotoService.swift
//  CWC FireBase photos
//
//  Created by VD on 17/08/2021.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth


class PhotoService{
    
    
    static func retrievPhotos(completion: @escaping([Photo])->Void){
        
        let db = Firestore.firestore()
        
        db.collection("photos").getDocuments { snapchot, error in
            if error != nil{
                
                return
            }
            
            let documents = snapchot?.documents
            
            var photoArray = [Photo]()
            
            if let documents = documents {
                
                for doc in documents{
                    
                    let p = Photo(snapchot: doc)
                    if p != nil{
                        photoArray.insert(p!, at: 0)
                    }
                }
                completion(photoArray)
            }
        }
        
        
    }
    
    
    
    static func savePhoto (image:UIImage, progressUpdate: @escaping (Double)->Void){
        
        guard Auth.auth().currentUser?.uid != nil else {return}
        
        let photoData = image.jpegData(compressionQuality: 0.1)
        guard photoData != nil else {return}
    
        
        let filename = UUID().uuid
        
        let userID = Auth.auth().currentUser?.uid
        
       let ref = Storage.storage().reference().child("images/\(userID)/\(filename).jpeg")
        
       let uploadTask = ref.putData(photoData!, metadata: nil) { metadata, error in
            if error == nil{
                self.createDataBaseEntry(ref)
                
            }
        }
        
        uploadTask.observe(.progress) { taskSnapshot in
         let pct = Double(taskSnapshot.progress!.completedUnitCount) / Double(taskSnapshot.progress!.totalUnitCount)
            print(pct)
            progressUpdate(pct)
        }
    }
    
    private static func createDataBaseEntry (_ ref: StorageReference){
        ref.downloadURL { URL, error in
            if error == nil{
                let photoID = ref.fullPath
                
                let photoUser = LocalStorageService.loadUser()
                
                let useriD = photoUser?.userId
                
                let username = photoUser?.username
                
                let df = DateFormatter()
                df.dateStyle = .full
                
                let dateString = df.string(from: Date())
                
                let metadata = ["photoID": photoID,"byiD":useriD!, "byUsername":username!, "date":dateString, "url":URL!.absoluteString]
                
                let db = Firestore.firestore()
                
                db.collection("photos").addDocument(data: metadata) { error in
                    if error != nil{
                        
                    }
                }
                
                
                
                
                
                
            }
        }
    }
    
}
