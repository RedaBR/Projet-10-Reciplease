//
//  RecipleaseService.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import Foundation

class RecipleaseService {
    // MARK: - Initialisation for network call and response management
    private init () {
    }

    static let shared = RecipleaseService()
    var session = URLSession(configuration: .default)
    var task = URLSessionTask()
    init(session: URLSession) {
        self.session = session
    }
    // MARK: - network call
    // Managements of url for get element to change
    let baseUrl = "https://api.edamam.com/api/recipes/v2?type=public"
    let idUrl = "app_id=12ec7565"
    let keyUrl = "app_key=05e5966e8a50363b67e726465b5d8850"
    // url : https://api.edamam.com/api/recipes/v2?type=public&q=poulet&app_id=12ec7565&app_key=05e5966e8a50363b67e726465b5d8850
    func getReciplease (ingredients: String?, callback: @escaping (InfosReciplease?, Bool, Error?) -> Void) {
        let url = getUrl(text: ingredients ?? "")
        // request with url
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Management response of nerwork call
        task = session.dataTask(with: request) { (data, response, error) in
            // asynchronous functions in threads
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    do {
                        let responseJson = try JSONDecoder().decode(InfosReciplease.self, from: data)
                        callback(responseJson, true, error)
                    } catch {
                        callback(nil, false, error)
                    }
                } else { callback(nil, false, error)}
            }
        }
        // execute task
        task.resume()
    }
    // MARK: - Url Management
    // URL gathering
    func getUrl (text: String) -> URL {
        let originalString = baseUrl + "&q=" + text + "&" + idUrl + "&" + keyUrl
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        return url!
    }
}
