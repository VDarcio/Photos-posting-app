//
//  FeedViewController.swift
//  CWC FireBase photos
//
//  Created by VD on 12/08/2021.
//

import UIKit

class FeedViewController: UIViewController {
  
    
    @IBOutlet weak var tableView: UITableView!
    
   var photos = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // add pull to refresh
        addFreshControll()
        
        PhotoService.retrievPhotos { retrievedphotos in
            
            
            self.photos = retrievedphotos
            self.tableView.reloadData()
        }
        
        
    }
    
    func addFreshControll(){
        let refresh = UIRefreshControl()
    
    refresh.addTarget(self, action: #selector(refreshFeed(refreshcontrol:)), for: .valueChanged)
        
        self.tableView.addSubview(refresh)
    
    }
    
    @objc func refreshFeed(refreshcontrol:UIRefreshControl){
        
        PhotoService.retrievPhotos { newPhotos in
            
            
            self.photos = newPhotos
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                refreshcontrol.endRefreshing()
            }
        }
        
    }
    
    


}


extension FeedViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return photos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
        
        let photo = self.photos[indexPath.row]
        
        cell?.displyaPhoto(photo)
        
        
        return cell!
    }
    
    
}
