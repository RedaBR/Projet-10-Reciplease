//
//  CustomFavCellTableViewCell.swift
//  Reciplease
//
//  Created by Reda on 15/05/2022.
//

import UIKit
// MARK: - Custom Cell Favorites 
class CustomFavCellTableViewCell: UITableViewCell {
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeIcon: UIImageView!
    // Associate elements of view to elements of CoreData 
    func initFavCell (recipe: CoreDataRecipe) {
        titre.text = recipe.title
        load.isHidden = false
        guard let urlString = recipe.imageUrl,
        let imageUrl: URL = URL(string: urlString)
        else {return}
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let imageData: NSData = try NSData(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.mainImg.image = image
                    self.load.isHidden = true
                }
            } catch {print(error.localizedDescription)
            }
        }
        descriptionLabel.text = recipe.descript
        timeLabel.text = String(recipe.time)
    }
}
