//
//  CustomFavCellTableViewCell.swift
//  Reciplease
//
//  Created by Reda on 15/05/2022.
//

import UIKit
// MARK:- Custom Cell Favorites 
class CustomFavCellTableViewCell: UITableViewCell {
    // éléments de la vue
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeIcon: UIImageView!
    
    // methode pour associé les élemens de la vue avec les élemens recupérés lors de l'appel reseau
    func initFavCell (recipe:CoreDataRecipe) {
        titre.text = recipe.title
        let imageUrl:URL = URL(string: recipe.imageUrl!)!
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let imageData:NSData = try NSData(contentsOf: imageUrl)
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.mainImg.image = image
                }
            }
            catch {
            }
        }
        descriptionLabel.text = recipe.descript
        likeLabel.text = String(recipe.likeCount)
        timeLabel.text = String(recipe.time)
    }
}
