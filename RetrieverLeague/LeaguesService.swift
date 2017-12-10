//
//  LeaguesService.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 12/10/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

class LeaguesService {
    
    static func getLeagues(completion: @escaping CompletionHandler) {
     
        BaseService.get(resource: Resource.leagues) { (error, json) in
         
            if let error = error {
                completion(error, nil)
                return
            }
            
            if let jsonArray = json as? JSONArray {
                let leagues = jsonArray.map { League(with: $0) }
                completion(nil, leagues)
            } else {
                completion(nil, nil)
            }
            
        }
        
        
    }
    
}
