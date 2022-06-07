//
//  RecipleaseService.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import Foundation

class RecipleaseService {
    // MARK:-  Initialisation for network call and response management
    private init () {
    }
    //création d'une propriété constante et  static qui a pour valeur l'initialisation de la classe RecipleaseService
    static let shared = RecipleaseService()
    // Utilisation du pattern singleton qui limite la classe a une seult instanciation
    // on initile la classe URLSession et URLSessionsTask hors de la methode qui effectue l'appel reseaux pour eviter d'effectuer plusieurs instanciantion
    var session = URLSession(configuration: .default)
    var task = URLSessionTask()
    init(session:URLSession) {
        self.session = session
    }
    
    // MARK:- network call
    
    // decomposition de l'url pour pouvoir changer l'élément qui contient les ingrédients de l'utilisateur
    let baseUrl = "https://api.edamam.com/api/recipes/v2?type=public"
    let idUrl = "app_id=12ec7565"
    let keyUrl = "app_key=05e5966e8a50363b67e726465b5d8850"
    // url : https://api.edamam.com/api/recipes/v2?type=public&q=poulet&app_id=12ec7565&app_key=05e5966e8a50363b67e726465b5d8850
    // // Methode pour l'appele reseaux, l'élement aléatoir de l'url de cette appel est mise en paramétre de la fonction qui est l'ensemble des ingrédients tapé par l'utilisateur listIngred.text
    func getReciplease (ingredients:String?, callback: @escaping (InfosReciplease?, Bool, Error?)->Void) {
        let url = getUrl(text: ingredients ?? "")
        
        // creationd de la requete avec l'init de la classe URLRequest et l'url
        var request = URLRequest(url: url)
        
        // identification de la méthode de la requete
        request.httpMethod = "GET"
        
        // creation  de la tache avec l'insatance de URLSessionTask() et accés a la méthode dataTask de session insatancié avec URLSession(). la méthode admets 3 paramétées de type DATA, HTTPURLRESPONSE, ET ERROR nécéssaire a la gestion de la reponse de l'appel reseaux
        task = session.dataTask(with: request) { (data, response, error) in
            
            // en attendant la reponse de l'appel reseaux le fonction change de Thread et se met sur le second thread que l'utilisateur ne voit pas donc on apelle la methode DispatchQueue qui permet de demander au systéme de continuer a fonctionner sur le thread principale de fonction asynchrone
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    //let dataString = String(data: data, encoding: .utf8)
                    do {
                        let responseJson = try JSONDecoder().decode(InfosReciplease.self, from:data)
                        callback(responseJson,true,error)
                    }
                    catch {
                        callback(nil,false,error)
                    }
                } else { callback(nil,false,error)}
            }
            
        }
        // lancement de la tache
        task.resume()
    }
    
    // MARK:-  Url Management
    
    // methode pour rassemebler l'url de l'appel reseaux avec l'élément aléatoire qui est en paramétre 
    func getUrl (text:String)->URL {
        let originalString = baseUrl + "&q=" + text + "&" + idUrl + "&" + keyUrl
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        return url!
    }
}
