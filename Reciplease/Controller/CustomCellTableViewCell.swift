//
//  CustomCellTableViewCell.swift
//  Reciplease
//
//  Created by Reda on 06/05/2022.
//

import UIKit
// MARK: - Custom Cell List
class CustomCellTableViewCell: UITableViewCell {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeIcon: UIImageView!
    func initCell(recipe: PropertiesReciplease) {
        loader.isHidden = false
        let imageUrl: URL = URL(string: recipe.imageUrl)!
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData: NSData = NSData(contentsOf: imageUrl)!
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
             let image = UIImage(data: imageData as Data)
               self.mainImg.image = image
                self.loader.isHidden = true
            }
       }
        self.titre.text = recipe.title
        self.descriptionLabel.text = recipe.descrip
        self.timeLabel.text = String(recipe.time)
    }
}
