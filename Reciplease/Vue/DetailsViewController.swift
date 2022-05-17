//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleRecip: UILabel!
    @IBOutlet weak var list: UITextView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    var recipe:PropertiesReciplease?
    var isFav = false
    var objectModel:CoreDataRecipe?
    
    @IBAction func addFav() {
        if (isFav) {
            CoreDataStack.sharedInstance.replace(sameRecipe: self.objectModel!)
        }else{
            save()
        }
    }
    func save () {
        
        let properties = CoreDataRecipe(context: CoreDataStack.sharedInstance.viewContext)
        properties.title = recipe!.title
        properties.descript = recipe!.descrip
        properties.imageUrl = recipe!.imageUrl
        properties.likeCount = Int16(recipe!.likeCount)
        properties.time = Int16(recipe!.time)
        
        let ingredientsLines = recipe?.ingredLines
        let listIngred = ingredientsLines?.joined(separator: "\n")
        properties.ingredLines = listIngred
        do {
            try CoreDataStack.sharedInstance.viewContext.save()
        }
        catch {
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //let imageUrl:URL = URL(string: recipe!.imageUrl)!
        // DispatchQueue.global(qos: .userInitiated).async {
        
        //let imageData:NSData = NSData(contentsOf: imageUrl)!
        
        // When from background thread, UI needs to be updated on main_queue
        // DispatchQueue.main.async {
        //let image = UIImage(data: imageData as Data)
        // self.mainImage.image = image
        //}
        //}
        self.titleRecip.text = recipe?.title
        let ingredientsLines = recipe?.ingredLines
        let listIngred = ingredientsLines?.joined(separator: "\n")
        list.text = listIngred
        
        CoreDataStack.sharedInstance.getPropertieWithTitle(title: self.recipe!.title) { (recipes) in
            
            //self.isFav = (recipes.count > 0)
            if (recipes.count > 0) {
                //existe deja
                self.isFav = true
                self.objectModel = recipes.first
            } else{
                // existe pas
                self.isFav = false
            }
        }
    }
}
