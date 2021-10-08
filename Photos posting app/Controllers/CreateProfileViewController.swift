//
//  CreateProfileViewController.swift
//  CWC FireBase photos
//
//  Created by VD on 12/08/2021.
//

import UIKit
import  FirebaseAuth

class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func confirmTapped(_ sender: UIButton) {
        guard Auth.auth().currentUser != nil else {return}
        
        
       let username = userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if username  == nil || username == ""{
            return
            
        }
        
        UserService.createProfile(userID: Auth.auth().currentUser!.uid, username: username!) { user in
            if user != nil{
                
                LocalStorageService.saveUser(userid: user?.userId, username: user?.username)
                
                let tabbarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBArController)
                self.view.window?.rootViewController = tabbarVC
                self.view.window?.makeKeyAndVisible()
            }else{
                
            }
        }
        
        
    }
}
