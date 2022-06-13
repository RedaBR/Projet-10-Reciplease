//
//  FavoritesDetailsViewController.swift
//  Reciplease
//
//  Created by Reda on 17/05/2022.
//

import UIKit
// MARK:- View Table Favorites Management
class FavoritesDetailsViewController: UIViewController {
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsList: UITextView!
    @IBOutlet weak var imgDetails: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
   
    
    
    @IBAction func deleteToFav(_ sender: UIButton) {
        CoreDataStack.sharedInstance.delete(recipeToDelete: recipe!)
        let image = UIImage(systemName: "star")
        sender.setImage(image, for: .normal)
    }
    // initialisation de l'objet recipe pour obtenir les éléments enregistré sur CoreData
    var recipe : CoreDataRecipe?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailsTitle.text = recipe?.title
        detailsList.text = recipe?.ingredLines
        let imageUrl:URL = URL(string: recipe!.imageUrl!)!
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.imgDetails.image = image
            }
        }
      
        timeLabel.text = String(recipe!.time)
    }
    
    func getRecipeToDelete () {
        CoreDataStack.sharedInstance.getPropertieWithTitle(uri: (recipe?.uri)!) { (recipeToDelete) in
            recipe = recipeToDelete.first
        }
    }
    
}
