//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit

// MARK:- Custom Details Recip List
class DetailsViewController: UIViewController {
    var object : CoreDataRecipe?
    var isFav = false
   
    @IBOutlet weak var titleRecip: UILabel!
    @IBOutlet weak var list: UITextView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    var recipe:PropertiesReciplease?
    
    @IBAction func addFav() {
            save()
    }
    // MARK:- Save to CoreData
    func save () {
        if (isFav == true) {
            presentAlert(with: "already in fav")
            return
        }
        let properties = CoreDataRecipe(context: CoreDataStack.sharedInstance.viewContext)
        properties.title = recipe!.title
        properties.descript = recipe!.descrip
        properties.imageUrl = recipe!.imageUrl
        properties.likeCount = Int16(recipe!.likeCount)
        properties.time = Int16(recipe!.time)
        let ingredientsLines = recipe?.ingredLines
        let listIngred = ingredientsLines?.joined(separator: "\n")
        properties.ingredLines = listIngred
        properties.uri = recipe?.uri
        do {
            try CoreDataStack.sharedInstance.viewContext.save()
            isFav = true
        }
        catch {
            presentAlert(with: error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataStack.sharedInstance.getPropertieWithTitle(uri: recipe?.uri ?? "") { (recipes) in
            if recipes.count>0 {
                isFav = true
                object = recipes.first
            }
            else {
                isFav = false
            }
        }
        let imageUrl:URL = URL(string: recipe!.imageUrl)!
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.mainImage.image = image
            }
        }
        self.titleRecip.text = recipe?.title
        
        let ingredientsLines = recipe?.ingredLines
        let listIngred = ingredientsLines?.joined(separator: "\n")
        list.text = listIngred
        
        likeLabel.text = String(recipe!.likeCount)
        
        timeLabel.text = String(recipe!.time)
        
    }
    
    // MARK:- Alert
    func presentAlert(with msg: String) {
        let alert = UIAlertController(title: "Erreur", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
