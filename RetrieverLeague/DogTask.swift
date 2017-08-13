//
//  DogTask.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 8/8/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

struct DogTask {
    
    var score: Int
    
    init?(with json: JSONObject) {
        guard let score = json["score"] as? Int else {
            return nil
        }
        self.score = score
    }
    
}
