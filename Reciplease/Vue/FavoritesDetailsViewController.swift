//
//  FavoritesDetailsViewController.swift
//  Reciplease
//
//  Created by Reda on 17/05/2022.
//

import UIKit
// MARK: - View Table Favorites Management
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
    var recipe: CoreDataRecipe?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailsTitle.text = recipe?.title
        detailsList.text = recipe?.ingredLines
        guard let urlString = recipe?.imageUrl,
        let imageUrl: URL = URL(string: urlString)
        else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            do { let imageData: NSData = try NSData(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.imgDetails.image = image
                }
            } catch { }
        }
        timeLabel.text = String(recipe!.time)
    }
    // Delete Recipe to Core Data 
    func getRecipeToDelete () {
        CoreDataStack.sharedInstance.getPropertieWithTitle(uri: (recipe?.uri)!) { (recipeToDelete) in
            recipe = recipeToDelete.first
        }
    }
}
