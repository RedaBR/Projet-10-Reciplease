//
//  CustomCellTableViewCell.swift
//  Reciplease
//
//  Created by Reda on 06/05/2022.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

  
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var titre: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeIcon: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(recipe:PropertiesReciplease) {
        
        let imageUrl:URL = URL(string: recipe.imageUrl)!
             
         // Start background thread so that image loading does not make app unresponsive
          DispatchQueue.global(qos: .userInitiated).async {
             
             let imageData:NSData = NSData(contentsOf: imageUrl)!
             
             // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.mainImg.image = image
             }
         }

        self.titre.text = recipe.title
        self.descriptionLabel.text = recipe.description
        self.likeLabel.text = String(recipe.likeCount)
        self.timeLabel.text = String(recipe.time)
    }
    

}
