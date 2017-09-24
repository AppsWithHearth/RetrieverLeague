//
//  UIView+IB.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 9/24/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}

