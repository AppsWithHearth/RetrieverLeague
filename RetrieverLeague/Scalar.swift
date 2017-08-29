//
//  Scalar.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 8/30/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

struct Scalar {
    
    
    var count: Int
    
    init?(with json: JSONObject) {
        
        guard let count = json["count"] as? Int else {
            return nil
        }
        
        self.count = count
        
    }
    
}
