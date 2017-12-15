//
//  DogResultTableViewCell.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 12/15/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class DogResultTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with dog: Dog, index: Int) {
        nameLabel.text = dog.name
        positionLabel.text = "\(index + 1)."
        scoreLabel.text = String(format: "%.2f%", dog.totalScore)
    }
    
}
