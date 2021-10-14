//
//  CameraViewController.swift
//  CWC FireBase photos
//
//  Created by VD on 12/08/2021.
//

import UIKit

class CameraViewController: UIViewController {

    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBOutlet weak var DoneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        progressBar.alpha = 0
        progressBar.progress = 0
        
        DoneButton.alpha = 0
        progressLabel.alpha = 0
    }
    

   func  savePhoto(image:UIImage){
        
    PhotoService.savePhoto(image: image) { pct in
       
        DispatchQueue.main.async {
            self.progressBar.alpha = 1
            self.progressBar.progress = Float(pct)
            
           
            let roundedpct = Int(pct * 100)
            self.progressLabel.text = "\(roundedpct) %"
            self.progressLabel.alpha = 1
            
            if roundedpct == 100{
                
                self.progressLabel.text = "Upload completed"
                self.DoneButton.alpha = 1
                
                
            }
        }
        
        
    }
    }
    
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        let tabBarVC = self.tabBarController as? MainTabController
        if let tabBarVC = tabBarVC{
            tabBarVC.goToFeed()
            
        }
    }
    
}


