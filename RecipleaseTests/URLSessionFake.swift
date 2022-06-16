//
//  URLSessionsFake.swift
//  RecipleaseTests
//
//  Created by Reda on 26/05/2022.
//

import Foundation
// MARK: - URL Session Fake

class URLSessionFake : URLSession {
    var data : Data?
    var error : Error?
    var response : URLResponse?
    // Initializer to be able to associate them with the desired values
    init(data:Data?, error:Error?, response:URLResponse?) {
        self.data=data
        self.error=error
        self.response = response
    }
    // Override of the dataTaske function necessary to manage the response during our network call
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        // associate the parameters of the closure that manages the response to our false properties
        let task = URLSessionDataTaskFake()
        task.callback = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}
// MARK: - URL Session Data Tak Fake

// Creation of a fake class URLSessionDataTask"Fake" of type real class URLSessionDataTask
class URLSessionDataTaskFake : URLSessionDataTask {
    var callback : ((Data?, URLResponse?, Error?) -> Void)?
    var data : Data?
    var urlResponse : URLResponse?
    var responseError : Error?
    // launch of the task with our false properties
    override func resume() {
        callback?(data, urlResponse, responseError)
    }
}
