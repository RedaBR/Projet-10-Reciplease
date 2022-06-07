//
//  URLSessionsFake.swift
//  RecipleaseTests
//
//  Created by Reda on 26/05/2022.
//

import Foundation
// MARK: - URL Session Fake

class URLSessionFake : URLSession {
    // creation d'une fake URLSession  avec ses propriétés
    var data : Data?
    var error : Error?
    var response : URLResponse?
    // initialisateur pour pouvoir les associés aux valeurs desirés
    init(data:Data?, error:Error?, response:URLResponse?) {
        self.data=data
        self.error=error
        self.response = response
    }
    // override de le fonction dataTaske nécéssaire a la gestion de la reponse lors notre appel reseaux
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        // on associe les paramétes de la closure qui gere la reponse aux nos fausse proprités
        let task = URLSessionDataTaskFake()
        task.callback = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}
// MARK: - URL Session Data Tak Fake

// creation d'une fausse classe URLSessionDataTask"Fake" de type veritable class URLSessionDataTask
class URLSessionDataTaskFake : URLSessionDataTask {
    // override de la variable avec comme type la closure avec les paramétés nécessaire pour lancer la tache
    var callback : ((Data?,URLResponse?,Error?)->Void)?
    // associations de nos fausse propriétés au proprités de le class
    var data : Data?
    var urlResponse : URLResponse?
    var responseError : Error?
    // lancement de la tache avec nos fausse propriétés 
    override func resume() {
        callback?(data, urlResponse, responseError)
    }
}
