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
<<<<<<< HEAD
    
    static func getDogsCount(completion: @escaping CompletionHandler) {
        
        BaseService.get(resource: Resource.dogsCount) { (error, json) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            if let jsonObject = json as? JSONObject {
                let countScalar = Scalar(with: jsonObject)
                completion(nil, countScalar)
            } else {
                completion(nil, nil)
            }
        }
    }
=======
>>>>>>> 39b997f4c757e1cb418d5aa847865f7b5aedadf5
}
