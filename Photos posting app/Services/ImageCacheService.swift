//
//  ImageCacheService.swift
//  CWC FireBase photos
//
//  Created by VD on 17/08/2021.
//

import Foundation
import UIKit


class ImageCacheService{
    
    
    static var imageCache = [String:UIImage]()
    
    
    static func saveImage(url:String?,image: UIImage?){
        
        //check against nill
        if url == nil || image == nil {
            return
        }
        //save image
        imageCache[url!] = image!
    }
    
    static func getImage(url:String?)->UIImage?{
        
        //check that url is not nil
        if url == nil{
            return nil
        }
        
        //check the imageCache for the url
        
        return imageCache[url!]
    }
}
