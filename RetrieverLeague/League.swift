//
//  League.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 10/17/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

struct League {
    var id: Int
    var name: String
    
    init?(with json: JSONObject) {
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String else {
            return nil
        }
        self.id = id
        self.name = name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}
