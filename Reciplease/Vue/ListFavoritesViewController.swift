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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        backUpList.removeAll()
       

        getFetch()
    }
    
    var backUpList : [CoreDataRecipe] = []
    
    func getFetch () {
        CoreDataStack.sharedInstance.getProperties { (savedProperties) in
            backUpList.append(contentsOf: savedProperties)
            ListFavTableView.reloadData()
            if backUpList.isEmpty {
                presentAlert(with: "explications")
               
            }
        }
        
    }
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension ListFavoritesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        backUpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListFavTableView.dequeueReusableCell(withIdentifier: "CustomFavCellTableViewCellID", for: indexPath) as! CustomFavCellTableViewCell
        
        let recipeCoreData = backUpList[indexPath.row]
        
        cell.initFavCell(recipe: recipeCoreData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recipeCoreData = backUpList[indexPath.row]
        performSegue(withIdentifier: "segueToFavoritesDetails", sender:recipeCoreData )
    }
}

