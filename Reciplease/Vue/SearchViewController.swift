//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    
    
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
        addIngred()
        ingredients.text = ""
    }
    
   
    @IBAction func deleteIngred() {
       
        var words = listIngred.text.components(separatedBy: "\n")
        words.removeLast()
       // words.removeLast()
        listIngred.text = words.joined(separator: "\n")
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
       
        return true
        
    }
    
    private func addIngred() {
        guard
            let ingredientsName = ingredients.text,
            var IngredList = listIngred.text
        else { return }
        
        IngredList += ingredientsName + "\n"
        listIngred.text = IngredList
    }
    
  
    
    private func getResult() {
        
        RecipleaseService.shared.getReciplease(ingredients: listIngred.text!) { (info, true,error) in
            // creation d'une instance unique de PropertiesRecipeService 
            let sharedPropertiesRecipe = PropertiesRecipService.shared
            // on nettoie le tableau de ce qu'il contenait précédement pour enlever les recettes des appels précédent
            sharedPropertiesRecipe.clearList()
            // on recupére hits qui est  un tableau contenant toutes les recettes reparties en élément  numérotés d'indice avec chaque élement les propriétés detaillés de la recette sinon on renvoir un tableau vide
            let hits = info?.hits ?? []
           
           
            // creation d'une boucle for qui parcours hits et et pour chaque élément de hits on recupére les proprirté avec la methode getPropertiesRecipleaseForHit
            for hit in hits {
                
                let recip = self.getPropertiesRecipleaseForHit(hit: hit)
                // on rajoute le resulatat au tableau addList qu'on va utiliser pour customiser nos celle pour la liste des recettes
                sharedPropertiesRecipe.addList(list: recip)
            }
            // on isntancie la classe ListRecipleaseViewController pour appler la methode presente pour transition 
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListRecipleaseViewControllerID") as! ListRecipleaseViewController
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    // methode pour recupérer les propriétés de l'appel reseaux avec pour paraméte HIT qui cotient les propriétés de la rectette
    func getPropertiesRecipleaseForHit(hit:Hit) -> PropertiesReciplease {
        let title =  hit.recipe?.label ?? ""
        // le propriété voulue est dans une tableau donc création d'une boucle for qui parcour le tableau et recupére l'elément food qui est mis dans le tableauc desc
        var desc:[String] = []
        let ingredients = hit.recipe?.ingredients ?? []
        for ing in ingredients {
            if ing.food != nil {
                desc.append(ing.food!)
            }
        }
        // rassemblement des élements du tableau desc en les séparant d'une virugule et une espace
        let description = desc.joined(separator: ", ")
        
        let imageUrl = hit.recipe?.image ?? ""
        let likeCount = 0
        let time = hit.recipe?.totalTime ?? 0
        let ingredLines = hit.recipe?.ingredientLines ?? [""]
        let uri = hit.recipe?.uri
        // instance de PropertiesReciplease pour pour valoriser les propriétés de la classe avec les élements récupérés via l'appel reseaux
        let recip =  PropertiesReciplease()
        recip.title = title
        recip.descrip = description
        recip.imageUrl = imageUrl
        recip.time = time
        recip.ingredLines = ingredLines
        recip.uri = uri!
        // on retourne l'instance avec les propriétés valorisés
        return recip
    }
}

