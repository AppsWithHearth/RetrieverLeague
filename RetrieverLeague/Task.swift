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
    var dogTask: DogTask?
    
    init?(with json: JSONObject) {
        
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let maximumScore = json["maximumScore"] as? Int,
            let dogTaskJson = json["dogTask"] as? JSONObject else {
                return nil
        }
        self.id = id
        self.name = name
        self.maximumScore = maximumScore
        self.dogTask = DogTask(with: dogTaskJson)
    }
}
