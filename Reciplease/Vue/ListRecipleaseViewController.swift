//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit

class ListRecipleaseViewController: UIViewController {
    
    var toto = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listReciplease.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.listReciplease.register(CustomCellTableViewCell.self, forCellReuseIdentifier: "ListReciplease")
    }
    
   
    @IBOutlet weak var listReciplease: UITableView!
    
}

extension ListRecipleaseViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PropertiesRecipService.shared.listRecip.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listReciplease.dequeueReusableCell(withIdentifier: "CustomCellTableViewCellID") as! CustomCellTableViewCell
        let recipe = PropertiesRecipService.shared.listRecip[indexPath.row]
      
        cell.initCell(recipe: recipe)

        return cell
    }
    
    
}
    
    


