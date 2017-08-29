//
//  ContestDogTableViewCell.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/25/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit
import FoldingCell

class ContestDogTableViewCell: FoldingCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let EXPANDED_HEIGHT: CGFloat = 50
    let ITEMS_IN_ROW: CGFloat = 4
    let ITEM_SPACING: CGFloat = 4
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var tasksHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var testResultsCollectionView: UICollectionView! {
        didSet {
            testResultsCollectionView.dataSource = self
            testResultsCollectionView.delegate = self
        }
    }
    var isExpanded = false
    var tasks = [Task]() {
        didSet {
            testResultsCollectionView.reloadData()
        }
    }
    
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
        self.tasks = dog.tasks ?? []
    }
    
    func showLoading() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType) -> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.testResultCell, for: indexPath) as! TestResultCollectionViewCell
        
        let task = tasks[indexPath.row]
        
        cell.configure(with: task)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width/ITEMS_IN_ROW - ITEM_SPACING
        
        let numberOfRows = ceil(CGFloat(tasks.count)/ITEMS_IN_ROW)
        
        let height = collectionView.frame.height / numberOfRows
        
        return CGSize(width: width, height: height)
    }
    
}

