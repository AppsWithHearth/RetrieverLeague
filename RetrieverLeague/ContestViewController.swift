//
//  ContestViewController.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/24/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class ContestViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var contest: Contest! {
        didSet {
            self.title = contest.name
        }
    }
    var dogsDict = [Int: [Dog]]()
    var dogCategories = [Int]()
    
    @IBOutlet weak var dogsTableView: UITableView! {
        didSet {
            dogsTableView.delegate = self
            dogsTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for dog in contest.dogs {
            if dogsDict[dog.leagueId] == nil {
                dogsDict[dog.leagueId] = [Dog]()
            }
            dogsDict[dog.leagueId]?.append(dog)
        }
        dogCategories = Array(dogsDict.keys)
        dogsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dogCategories.count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = dogCategories[section]
        return dogsDict[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.contestDogCell, for: indexPath) as! ContestDogTableViewCell
        
        let leagueId = dogCategories[indexPath.section]
        if let dog = dogsDict[leagueId]?[indexPath.row] {
            
            cell.configure(with: dog, index: indexPath.row)
            
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionCell = tableView.dequeueReusableCell(withIdentifier: CellID.contestSectionCell) as! ContestSectionTableViewCell
        
        sectionCell.leagueNameLabel.text = LeagueHelper.categoryName(for: dogCategories[section])
        
        return sectionCell
        
    }
    
}
