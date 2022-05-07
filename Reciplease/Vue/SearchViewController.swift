//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    var recipe : InfosReciplease?
    
    @IBOutlet weak var listIngred: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        ingredients.delegate = self
        ingredients.becomeFirstResponder()
       
    
    }
    override func viewWillAppear(_ animated: Bool) {

       super.viewWillAppear(animated)
        

    }
  
     
    @IBAction func SearchRecipe() {
        getResult()
    }
    
    
    @IBOutlet weak var ingredients: UITextField!
    
    
    
    
    @IBAction func addIngredToList() {
    }
    
    
    
    @IBAction func deleteIngredToList() {
    }
    
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
 
        
        textField.resignFirstResponder()
        addIngred()
        
        return true

        
    }
    
  
    private func addIngred() {
        guard
            let IngredientsName = ingredients.text,
            var IngredList = listIngred.text
        else { return }

        IngredList += IngredientsName + "\n"
        listIngred.text = IngredList
        //ingredients.text = ""

        
    }
   
     
    private func getResult() {
        
         let ingredName = ingredients.text
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListRecipleaseViewControllerID") as! ListRecipleaseViewController
       
        
        RecipleaseService.shared.getReciplease(ingredients: ingredName!) { (info, true,error) in
            
            let sharedPropertiesRecipe = PropertiesRecipService.shared
            sharedPropertiesRecipe.clearList()
            
            let hits = info?.hits ?? []
            let image1 = info?.hits
            
            for hit in hits {
                let labelRecip = hit.recipe?.label
                let imageRecip = hit.recipe?.image
                let recip = PropertiesReciplease(label: labelRecip!)
                sharedPropertiesRecipe.addList(list: recip)
            }
            
            self.present(vc, animated: true, completion: nil)
        }
       
    }
    
  
    
    
}

