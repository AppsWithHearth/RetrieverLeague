//
//  ContestTableViewCell.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/19/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class ContestTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with contest: Contest) {
        nameLabel.text = contest.name
        dateLabel.text = contest.date?.string(with: "dd/MM/yyyy") ?? "Unknown"
        locationLabel.text = contest.location
        
    }

}
