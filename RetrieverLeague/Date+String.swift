//
//  Date+String.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/26/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import Foundation

extension Date {
    
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    
    func date(with format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
}
