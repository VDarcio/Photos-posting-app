//
//  PhotoCell.swift
//  CWC FireBase photos
//
//  Created by VD on 17/08/2021.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var photo : Photo?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func displyaPhoto (_ photo : Photo){
        
        //reset the image
        self.photoImageView.image = nil
        
        //set photo property
        self.photo = photo
        
        
        userNameLabel.text = photo.byUsername
        
        dateLabel.text = photo.date
        
        if photo.url == nil{
            return
        }
        
        let url = URL(string: photo.url!)
        
        if url == nil{
            return
        }
        
        //check if image is in cache
        if let cachedImage = ImageCacheService.getImage(url:photo.url! ){
            
            //use cached image
            self.photoImageView.image = cachedImage
            
            //return because we no longer need to download
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, URLResponse, error in
            
            if error == nil && data != nil{
                
                let image = UIImage(data: data!)
                //store the image in cache
                ImageCacheService.saveImage(url: url?.absoluteString, image: image)
                
                //check that the image data we download matches the phtp this cell suposed to display
                
                if url!.absoluteString != self.photo?.url{
                    return
                }
                
                
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            }
        }
        dataTask.resume()
        
    }
}
