//
//  Networker.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/03.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation

class Networker {
    
    enum RequestType {
        case GET
        case POST
    }
    
    var site: String = ""
    var query: String = ""
    var requestType: RequestType
    var responseData: Data? = nil
    var responseReady: Bool = false
    
    required init(site: String, query: String, requestType: RequestType) {
        self.site = site
        self.query = query
        self.requestType = requestType
    }
    
    func send(completion: @escaping (Data?) -> Void) {
        
        let urlString = "\(site)\(query)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        if let url = url {
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request as URLRequest, completionHandler: {
                (data, response, error)  in
                
                guard error == nil else {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                completion(data)
            })
            task.resume()
        }
    }
    
    func isDataReady() -> Bool {
        if let data = responseData {
            return true
        } else {
            return false
        }
    }
 
}
