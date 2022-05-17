//
//  ListFavoritesViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit

class ListFavoritesViewController: UIViewController {
    
    @IBOutlet weak var ListFavTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListFavTableView.delegate = self
        ListFavTableView.dataSource = self
        
        getFetch()
    }
    var backUpList : [CoreDataRecipe] = []
    let recipe = PropertiesReciplease()
    
    func getFetch () {
        
        CoreDataStack.sharedInstance.getProperties { (savedProperties) in
            backUpList.append(contentsOf: savedProperties)
            ListFavTableView.reloadData()
        }
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
}
