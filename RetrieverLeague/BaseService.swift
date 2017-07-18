//
//  BaseService.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/18/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation
import Alamofire
import ResponseDetective

typealias CompletionHandler = (Error?, Any?) -> Void
typealias ObjectCompletionHandler = (Error?, JSONObject?) -> Void
typealias ArrayCompletionHandler = (Error?, JSONArray?) -> Void
typealias JSONObject = [String: Any]
typealias JSONArray = [JSONObject]

class BaseService {
    
    static let sessionManager: Alamofire.SessionManager = {
        
        let configuration = URLSessionConfiguration.default
        
        //Use ResponseDetective only for testing - slows down response time
        //TODO: comment this for release
        ResponseDetective.enable(inConfiguration: configuration)
        let session = Alamofire.SessionManager(configuration: configuration)
        return session
        
    }()
    
    static func get(resource: String, parameters: Parameters? = [:], completion: @escaping CompletionHandler) {
        sessionManager.request(baseUrl + resource, method: .get,
                               parameters: parameters)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success:
                    guard let responseData = response.data else {
                        completion(nil, nil)
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                        completion(nil, json)
                    } catch let error {
                        completion(error, nil)
                    }
                case .failure(let error):
                    completion(error, nil)
                }
        }
        
    }
}
