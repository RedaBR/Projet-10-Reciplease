//
//  CustomFavCellTableViewCell.swift
//  Reciplease
//
//  Created by Reda on 15/05/2022.
//

import UIKit

class CustomFavCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func initFavCell (recipe:CoreDataRecipe) {
        titre?.text = recipe.title!
    }
}
