//
//  ListFavoritesViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit
// MARK: - List of Favorites
class ListFavoritesViewController: UIViewController {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var ListFavTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        ListFavTableView.delegate = self
        ListFavTableView.dataSource = self
    }
    override func viewWillDisappear(_ animated: Bool) {
    }
    override func viewDidAppear(_ animated: Bool) {
        backUpList.removeAll()
        getFetch()
    }
    var backUpList: [CoreDataRecipe] = []
    func getFetch () {
        CoreDataStack.sharedInstance.getProperties { (savedProperties) in
            backUpList.append(contentsOf: savedProperties)
            ListFavTableView.reloadData()
            if backUpList.isEmpty {
                presentAlert(with: " You can indicate the foods you have in the Search tab at the bottom of the screen to get delicious recipes.\n \n You can add your favorite recipes by selecting the recipe from the list provided and using the star at the top right. \n \n So you can find your favorite recipes in this Fav tab. \n \n To remove a recipe from your favourites, select the recipe from the favorites list and press the green star at the top of the screen.")
            }
        }
    }
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Indications", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
// MARK: - DataSourceDelegate

// number of lines per section
extension ListFavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        backUpList.count
    }
    // cum of the cells with the method dequeueReusableCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListFavTableView.dequeueReusableCell(withIdentifier: "CustomFavCellTableViewCellID", for: indexPath) as? CustomFavCellTableViewCell
        // number of cells
        let recipeCoreData = backUpList[indexPath.row]
        cell?.initFavCell(recipe: recipeCoreData)
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeCoreData = backUpList[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoritesDetailsID") as? FavoritesDetailsViewController
        vc?.recipe = recipeCoreData
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
