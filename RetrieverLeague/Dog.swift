//
//  Dog.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/18/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

struct Dog {
    
    var id: Int
    var name: String
    var breed: String
    var dateOfBirth: Date?
    var ownerName: String
    var league: League
    var tasks: [Task]?
    
    init?(with json: JSONObject) {
        
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let breed = json["breed"] as? String,
            let league = json["league"] as? JSONObject else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.breed = breed
        self.league = League(with: league) ?? League(id: -1, name: "Uncategorized")
        
        //nullable values
        self.ownerName = json["ownerName"] as? String ?? "Unknown"
        
        let dateOfBirth = json["dateOfBirth"] as? String ?? "Unknown"
        self.dateOfBirth = dateOfBirth.date(with: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    }
    
}
