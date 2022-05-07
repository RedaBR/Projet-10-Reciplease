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
    
    var session = URLSession(configuration: .default)
    var task = URLSessionTask()
    
    static let shared = RecipleaseService()
    
    let baseUrl = "https://api.edamam.com/api/recipes/v2?type=public"
    let idUrl = "app_id=12ec7565"
    let keyUrl = "app_key=05e5966e8a50363b67e726465b5d8850"
    
    // url : https://api.edamam.com/api/recipes/v2?type=public&q=poulet&app_id=12ec7565&app_key=05e5966e8a50363b67e726465b5d8850
    func getReciplease (ingredients:String, callback: @escaping (InfosReciplease?, Bool, Error?)->Void) {
        
        let url = getUrl(text: ingredients)
      
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
       
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    
                    do {
                        let responseJson = try JSONDecoder().decode(InfosReciplease.self, from:data)
                        callback(responseJson,true,error)
                    }
                    catch {
                      callback(nil,false,error)
                   }
                }
            }
           
        }
//
        task.resume()
    }
    
    func getUrl (text:String)->URL {
        let urlString = baseUrl + "&q=" + text + "&" + idUrl + "&" + keyUrl
        let url = URL(string: urlString)
        return url!
    }
    
}
