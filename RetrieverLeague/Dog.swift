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
    var dateOfBirth: String
    var ownerName: String
    var leagueId: Int
    
    init?(with json: JSONObject) {
        
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let breed = json["breed"] as? String,
            let leagueId = json["leagueId"] as? Int else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.breed = breed
        self.leagueId = leagueId
        
        //nullable values
        self.dateOfBirth = json["dateOfBirth"] as? String ?? "Unknown"
        self.ownerName = json["ownerName"] as? String ?? "Unknown"
    }
    
}
