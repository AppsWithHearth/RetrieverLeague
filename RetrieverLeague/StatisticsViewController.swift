//
//  StatisticsViewController.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 8/29/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class StatisticsViewController: BaseViewController {
    
    @IBOutlet weak var numberOfContestsLabel: UILabel!
    @IBOutlet weak var numberOfDogsLabel: UILabel!
    @IBOutlet weak var statisticsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleImage = #imageLiteral(resourceName: "icon_statistic")
        statisticsStackView.isHidden = true
        
        getCounts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCounts() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        self.showLoading()
        DogsService.getDogsCount { (error, dogsCountResponse) in
            
            if error == nil,
                let dogsCount = dogsCountResponse as? Scalar {
                self.numberOfDogsLabel.text = "\(dogsCount.count)"
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        ContestsService.getContestsCount { (error, contestsCountResponse) in
            
            if error == nil,
                let contestsCount = contestsCountResponse as? Scalar {
                self.numberOfContestsLabel.text = "\(contestsCount.count)"
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { 
            self.hideLoading()
            self.statisticsStackView.isHidden = false
        }
    }
    
    func getNumberOfContests() {
        self.showLoading()
        
    }
    
    
}
