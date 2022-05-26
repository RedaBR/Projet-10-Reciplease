//
//  URLSessionsFake.swift
//  RecipleaseTests
//
//  Created by Reda on 26/05/2022.
//

import Foundation
class URLSessionFake : URLSession {
    
    var data : Data?
    var error : Error?
    var response : URLResponse?
    
    init(data:Data?, error:Error?, response:URLResponse?) {
        self.data=data
        self.error=error
        self.response = response
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.callback = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        
        return task
    }
}


class URLSessionDataTaskFake : URLSessionDataTask {
    
    var callback : ((Data?,URLResponse?,Error?)->Void)?
    
    var data : Data?
    var urlResponse : URLResponse?
    var responseError : Error?
    
    override func resume() {
        callback?(data, urlResponse, responseError)
    }
}
