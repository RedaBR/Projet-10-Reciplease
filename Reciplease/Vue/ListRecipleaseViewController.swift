//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit
// MARK:- View Table List Recip Management

class ListRecipleaseViewController: UIViewController {

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
        let recip = PropertiesRecipService.shared.listRecip[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewControllerID") as! DetailsViewController
        vc.recipe = recip
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}




