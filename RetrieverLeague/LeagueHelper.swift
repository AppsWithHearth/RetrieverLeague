//
//  LeagueHelper.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/26/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

enum LeagueType: Int {
    case beginner = 1
    case open = 2
}

class LeagueHelper {
    
    static func categoryName(for leagueId: Int) -> String {
        switch leagueId {
        case LeagueType.beginner.rawValue:
            return "Anfänger"
        case LeagueType.open.rawValue:
            return "Offen"
        default:
            return "Uncategorized"
        }
    }
}
