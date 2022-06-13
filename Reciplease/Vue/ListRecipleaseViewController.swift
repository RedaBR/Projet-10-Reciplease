//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit
// MARK:- View Table List Recip Management

class ListRecipleaseViewController: UIViewController {
    // methode de passage de donnée de controleur à l'autre  avec pour paramétre sender qui est l'objet d'ou part le segue 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let successVC = segue.destination as? DetailsViewController
            let recip = sender as! PropertiesReciplease
            successVC?.recipe = recip
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listReciplease.dataSource = self
        self.listReciplease.delegate = self
    }
    @IBOutlet weak var listReciplease: UITableView!
    
}

// MARK:- DataSourceDelegate
extension ListRecipleaseViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PropertiesRecipService.shared.listRecip.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listReciplease.dequeueReusableCell(withIdentifier: "CustomCellTableViewCellID") as! CustomCellTableViewCell
        let recipe = PropertiesRecipService.shared.listRecip[indexPath.row]
        
        cell.initCell(recipe: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = PropertiesRecipService.shared.listRecip[indexPath.row]
        
        performSegue(withIdentifier: "segueToDetails", sender: recipe)
    }
    
}




