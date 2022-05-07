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
        listReciplease.dataSource = self
        
        listReciplease.register(CustomCellTableViewCell.self, forCellReuseIdentifier: "ListReciplease")

    }
    
   
    @IBOutlet weak var listReciplease: UITableView!
    
}

extension ListRecipleaseViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PropertiesRecipService.shared.listRecip.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListReciplease") as! CustomCellTableViewCell
        let recipe = PropertiesRecipService.shared.listRecip[indexPath.row]
      
        
        var content = cell.defaultContentConfiguration()
        

        // Configure content.
        //content.image = recipe.image1
        content.text = recipe.label
       
        cell.configure(title: content.text!)

        // Customize appearance.
        //content.imageProperties.tintColor = .purple
        //cell.configure(title: content.text!)
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
    
    


