//
//  DogsService.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/18/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

class DogsService {
    
    static func getDogs(completion: @escaping CompletionHandler) {
   
        BaseService.get(resource: Resource.dogs) { (error, json) in
            if let jsonArray = json as? JSONArray {
                let dogs = jsonArray.map {
                    return Dog(with: $0)
                }
                completion(nil, dogs)
            }
        }
    
    }
}
