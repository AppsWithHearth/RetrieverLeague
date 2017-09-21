//
//  TasksService.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 8/8/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

class TasksService {
    
    static func getTasks(forDog dogId: Int, contestId: Int, completion: @escaping CompletionHandler) {
        
        let resourceWithParams = "\(Resource.tasks)/\(dogId)/\(contestId)"
        
        BaseService.get(resource: resourceWithParams) { (error, json) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            if let jsonArray = json as? JSONArray {
                let tasks = jsonArray.map {
                    return Task(with: $0)
                }
                completion(nil, tasks)
            }
        }
        
    }
}
