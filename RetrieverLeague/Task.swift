//
//  Task.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 8/8/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

struct Task {
    
    var id: Int
    var name: String
    var maximumScore: Int
    var dogTasks: [DogTask]
    
    init?(with json: JSONObject) {
        
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let maximumScore = json["maximumScore"] as? Int,
            let dogTasks = json["dogTasks"] as? JSONArray else {
                return nil
        }
        self.id = id
        self.name = name
        self.maximumScore = maximumScore
        self.dogTasks = dogTasks.flatMap { DogTask(with: $0) }
    }
}
