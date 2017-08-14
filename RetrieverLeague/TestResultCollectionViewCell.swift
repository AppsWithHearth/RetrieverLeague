//
//  TestResultCollectionViewCell.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 8/13/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class TestResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var taskLabel: UILabel!
    
    func configure(with task: Task) {
        
        if let score = task.dogTask?.score {
            taskLabel.text = "\(task.name): \(score)"
        } else {
            taskLabel.text = "Unavailable"
        }
        
    }
    
}
