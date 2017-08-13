//
//  ContestDogTableViewCell.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/25/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit
import FoldingCell

class ContestDogTableViewCell: FoldingCell {

    let EXPANDED_HEIGHT: CGFloat = 50
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var tasksHeightConstraint: NSLayoutConstraint!
    
    var isExpanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with dog: Dog, index: Int) {
        rankLabel.text = "\(index + 1)"
        nameLabel.text = dog.name
        breedLabel.text = dog.breed
        birthLabel.text = dog.dateOfBirth?.string(with: "dd/MM/yyyy") ?? "Unknown"
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType) -> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
}

