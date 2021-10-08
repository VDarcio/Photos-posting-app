//
//  MainTabController.swift
//  CWC FireBase photos
//
//  Created by VD on 16/08/2021.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 2{
            //camera
            
            
            let actionSheet = UIAlertController(title: "add a photo", message: "select a source", preferredStyle: .actionSheet)
            
            if  UIImagePickerController.isSourceTypeAvailable(.camera){
                
                
                let cameraButton = UIAlertAction(title: "Camera", style: .default) { action in
                    self.showimagePickerController(mode: .camera)
                    
                }
                actionSheet.addAction(cameraButton)
                
            }
            
            let libraryButton = UIAlertAction(title: "Photo Library", style: .default) { action in
                self.showimagePickerController(mode: .photoLibrary)
                
            }
            actionSheet.addAction(libraryButton)
            
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            actionSheet.addAction(cancelButton)
            
            present(actionSheet, animated: true, completion: nil)
        }
        
        
        
    }
    
    func showimagePickerController(mode: UIImagePickerController.SourceType){
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = mode
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
        
    }

  
}


extension MainTabController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if let selectedImage = selectedImage{
            
           let cameraVC = self.selectedViewController as? CameraViewController
            
            if let cameraVC = cameraVC{
                cameraVC.savePhoto(image: selectedImage)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func goToFeed(){
        
        selectedIndex = 0
    }
}
