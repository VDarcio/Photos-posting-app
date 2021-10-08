//
//  LogInViewController.swift
//  CWC FireBase photos
//
//  Created by VD on 12/08/2021.
//

import UIKit
import FirebaseUI

class LogInViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    

  
    @IBAction func LoginTapped(_ sender: UIButton) {
        
        let authUI = FUIAuth.defaultAuthUI()
        
        if let authUI = authUI{
            
            authUI.delegate = self
            
            authUI.providers = [FUIEmailAuth()]
            
            let authViewController = authUI.authViewController()
            
            present(authViewController, animated: true, completion: nil)
        }
        
        
    }
    
}

extension LogInViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if error != nil{
            
            return
        }
        
        let user = authDataResult?.user
        
        if let user = user {
            
            UserService.retrieveProfile(userId: user.uid) { user in
                if user == nil{
                    self.performSegue(withIdentifier: Constants.Storyboard.profilesegue, sender: self)
                }else{
                    
                    LocalStorageService.saveUser(userid: user!.userId, username: user!.username)
                    
                    
                    
                   let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBArController)
                    
                    guard tabBarVC != nil else{return}
                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                    
                }
            }
            
            
        }
        
    }
}
