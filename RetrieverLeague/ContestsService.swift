//
//  ContestsService.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/18/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

class ContestsService {
    
    static func getContests(completion: @escaping CompletionHandler) {
        
        BaseService.get(resource: Resource.contests) { (error, json) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            if let jsonArray = json as? JSONArray {
                let contests = jsonArray.map {
                    return Contest(with: $0)
                }
                completion(nil, contests)
            } else {
                completion(nil, nil)
            }
        }
        
    }
    
}
