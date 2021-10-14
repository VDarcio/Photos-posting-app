//
//  SettingsViewController.swift
//  CWC FireBase photos
//
//  Created by VD on 12/08/2021.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logOutTapped(_ sender: Any) {
        
        try? Auth.auth().signOut()
        
        LocalStorageService.clearUser()
        
        let loginNavvc = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginNavcontroller)
        
        self.view.window?.rootViewController = loginNavvc
        self.view.window?.makeKeyAndVisible()
    }
}
