//
//  FavoritesDetailsViewController.swift
//  Reciplease
//
//  Created by Reda on 17/05/2022.
//

import UIKit

class FavoritesDetailsViewController: UIViewController {

    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsList: UITextView!
    @IBOutlet weak var imgDetails: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBAction func deleteInFav() {
        CoreDataStack.sharedInstance.delete(recipeToDelete: recipe!)
    }
    
    var recipe : CoreDataRecipe?
        override func viewDidLoad() {
        super.viewDidLoad()

}
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.detailsTitle.text = recipe?.title
        detailsList.text = recipe?.ingredLines
    }
    
    func getRecipeToDelete () {
        
        CoreDataStack.sharedInstance.getPropertieWithTitle(title: (recipe?.title)!) { (recipeToDelete) in
            recipe = recipeToDelete.first
        }
    }

}
