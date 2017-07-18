//
//  Contest.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/18/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

struct Contest {
    
    var id: Int
    var name: String
    var date: String
    var location: String
    var dogs: [Dog]
    
    init?(with json: JSONObject) {
        
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let date = json["date"] as? String,
            let location = json["location"] as? String,
            let dogs = json["dogs"] as? [JSONObject] else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.location = location
        self.date = date
        self.dogs = dogs.flatMap { Dog(with: $0) }
        
        
    }
    
}
