// MARK: - Search
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
    // MARK: - Search Recipe
    @IBAction func SearchRecipe() {
        getResult()
    }
    // MARK: - Add Ingred to List for get Recip
    @IBOutlet weak var ingredients: UITextField!
    @IBAction func addIngredToList() {
        addIngred()
        ingredients.text = ""
    }
    // MARK: - Delete ingred to list for Recip
    @IBAction func deleteIngred() {
        // split list ingred
        var words = listIngred.text.components(separatedBy: "\n")
        if words.contains("") {
            let index =  words.lastIndex(of: "")
            words.remove(at: index!)
        }
        // delete lase ingred to list
        if words.isEmpty == false {
            words.removeLast()
        }
        // join list ingred to display
        listIngred.text = words.joined(separator: "\n")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
    // MARK: - Get Recipes in fuction of ingred add to list
    private func getResult() {
        RecipleaseService.shared.getReciplease(ingredients: listIngred.text!) { (info, succes, error) in
            if succes {
                let sharedPropertiesRecipe = PropertiesRecipService.shared
                // clear old items to list
                sharedPropertiesRecipe.clearList()
                // recovery recipes in list
                let hits = info?.hits ?? []
                for hit in hits {
                    let recip = self.getPropertiesRecipleaseForHit(hit: hit)
                    //  add result to the addList table that we will use to customize cell
                    sharedPropertiesRecipe.addList(list: recip)
                }
                // instantiate ListRecipleaseViewController
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListRecipleaseViewControllerID") as? ListRecipleaseViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            } else { self.presentAlert(with: "Veuillez vérifier l'état de votre réseau")}
        }
    }
    // Method to retrieve the properties of the network call
    func getPropertiesRecipleaseForHit(hit: Hit) -> PropertiesReciplease {
        let title =  hit.recipe?.label ?? ""
        // Retrieve the properties of the network call
        var desc: [String] = []
        let ingredients = hit.recipe?.ingredients ?? []
        for ing in ingredients where ing.food != nil {
            desc.append(ing.food!)
            }
        let description = desc.joined(separator: ", ")
        let imageUrl = hit.recipe?.image ?? ""
        let time = hit.recipe?.totalTime ?? 0
        let ingredLines = hit.recipe?.ingredientLines ?? [""]
        let uri = hit.recipe?.uri
        // Put the result of nertwork call in properties of PropertiesReciplease
        let recip =  PropertiesReciplease()
        recip.title = title
        recip.descrip = description
        recip.imageUrl = imageUrl
        recip.time = time
        recip.ingredLines = ingredLines
        recip.uri = uri!
        // return the instancant withe properties valorised
        return recip
    }
    func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Indications", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
