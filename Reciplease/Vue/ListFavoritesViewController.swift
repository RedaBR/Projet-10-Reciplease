//
//  ListFavoritesViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit

class ListFavoritesViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavoritesDetails" {
            let successVC = segue.destination as? FavoritesDetailsViewController
            let recip = sender as! CoreDataRecipe
            successVC?.recipe = recip
        }
    }
    
    @IBOutlet weak var ListFavTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListFavTableView.delegate = self
        ListFavTableView.dataSource = self
        getFetch()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    var backUpList : [CoreDataRecipe] = []
   
    
    func getFetch () {
        
        CoreDataStack.sharedInstance.getProperties { (savedProperties) in
            backUpList.append(contentsOf: savedProperties)
            ListFavTableView.reloadData()
            
            
        }
        //CoreDataStack.sharedInstance.delete(recipeToDelete: backUpList[0])
    }
}

extension ListFavoritesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        backUpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListFavTableView.dequeueReusableCell(withIdentifier: "CustomFavCellTableViewCellID", for: indexPath) as! CustomFavCellTableViewCell
        //let cell = ListFavTableView.dequeueReusableCell(withIdentifier:"FavListID") as! CustomFavCellTableViewCell
        let recipeCoreData = backUpList[indexPath.row]
        //cell.title?.text = recipeCoreData.title
        cell.initFavCell(recipe: recipeCoreData)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let recipeCoreData = backUpList[indexPath.row]
        performSegue(withIdentifier: "segueToFavoritesDetails", sender:recipeCoreData )
    }
}

