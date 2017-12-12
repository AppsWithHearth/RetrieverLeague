//
//  DogContest.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 12/12/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

struct DogContest {
    
    var result: Double
    
    init?(with json: JSONObject) {
        guard let result = json["result"] as? Double else {
            return nil
        }
        self.result = result
    }
}
