//
//  Constants.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/18/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation


let baseUrl = "https://retriever-league.herokuapp.com"

struct Resource {
    static let dogs = "/dogs"
    static let contests = "/contests"
    static let count = "/count/all"
    static let dogsCount = Resource.dogs + Resource.count
    static let contestsCount = Resource.contests + Resource.count
}

struct CellID {
    static let contestCell = "contestCell"
    static let contestDogCell = "contestDogCell"
    static let contestSectionCell = "contestSectionCell"
}

struct Segue {
    static let contestsToContest = "contestsToContestSegue"
}
