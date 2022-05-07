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
    
    @IBOutlet weak var time: UIImageView!
    
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var note: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String)  {

       //mainImg.image = UIImage(named: icon)
        titre?.text = title
        //detail.text = description

    }

}
