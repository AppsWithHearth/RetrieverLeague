//
//  MessagesService.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 9/21/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

class MessagesService {
    
    static func sendContactMessage(email: String, message: String, completion: @escaping CompletionHandler) {
        
        let parameters = [
            "email": email,
            "message": message
        ]
        
        BaseService.post(resource: Resource.contactMessages, parameters: parameters) { (error, json) in
            if let error = error {
                completion(error, nil)
                return
            }
            
            if let jsonObject = json as? JSONObject {
                completion(nil, jsonObject)
            }
        }
        
    }
    
}
