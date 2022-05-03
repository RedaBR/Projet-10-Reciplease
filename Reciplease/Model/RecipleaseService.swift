//
//  RecipleaseService.swift
//  Reciplease
//
//  Created by Reda on 03/05/2022.
//

import Foundation
class RecipleaseService {
    
    private init() {
        
    }
    
    var session = URLSession()
    var task = URLSessionTask()
    
    static let shared = RecipleaseService()
    
    // url : https://api.edamam.com/api/recipes/v2?type=public&q=poulet&app_id=12ec7565&app_key=05e5966e8a50363b67e726465b5d8850
    func getReciplease (callback: @escaping (InfosReciplease?, Bool)->Void) {
         
        let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=poulet&app_id=12ec7565&app_key=05e5966e8a50363b67e726465b5d8850")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    let responseJson = try! JSONDecoder().decode(InfosReciplease.self, from:data)
                    do {
                       callback(responseJson,true)
                    }
                    catch {
                        callback(nil,false)
                    }
                }
            }
            
        }
        task.resume()
    }
}
