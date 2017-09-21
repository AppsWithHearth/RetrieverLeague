//
//  ErrorHelper.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 9/22/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

struct ErrorHelper {
 
    static func showAlert(title: String, message: String, from: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        from.present(alert, animated: true, completion: nil)
    }
    
}
