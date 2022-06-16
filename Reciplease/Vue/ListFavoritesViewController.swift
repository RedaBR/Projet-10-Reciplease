//
//  ListFavoritesViewController.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import UIKit
// MARK: - List of Favorites
class ListFavoritesViewController: UIViewController {

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
