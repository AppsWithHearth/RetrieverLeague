//
//  ContestsViewController.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/18/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class ContestsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var contestsTableView: UITableView! {
        didSet {
            contestsTableView.delegate = self
            contestsTableView.dataSource = self
        }
    }
    
    var contests = [Contest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleImage = #imageLiteral(resourceName: "icon_result")
        
        getContests()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - API Methods
    
    func getContests() {
        
        ContestsService.getContests { (error, contestsArray) in
            
            if let contests = contestsArray as? [Contest] {
                self.contests = contests
                self.contestsTableView.reloadData()
            }
            
        }
        
    }
    
    //MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.contestCell, for: indexPath) as! ContestTableViewCell
        
        let contest = contests[indexPath.row]
        
        cell.configure(with: contest)
        
        return cell
    }
}
