//
//  ContestViewController.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/24/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit
import FoldingCell

fileprivate struct C {
    struct CellHeight {
        static let close: CGFloat = 40 // equal or greater foregroundView height
        static let open: CGFloat = 80 // equal or greater containerView height
    }
}

class ContestViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var contest: Contest! {
        didSet {
            self.title = contest.name
        }
    }
    var dogsDict = [Int: [Dog]]()
    var dogCategories = [Int]()
    var cellHeights = (0..<100).map { _ in C.CellHeight.close }
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.contestDogCell, for: indexPath) as! ContestDogTableViewCell
        
        let leagueId = dogCategories[indexPath.section]
        if let dog = dogsDict[leagueId]?[indexPath.row] {
            
            cell.configure(with: dog, index: indexPath.row)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == C.CellHeight.close { // open cell
            cellHeights[indexPath.row] = C.CellHeight.open
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = C.CellHeight.close
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.5
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
        let leagueId = dogCategories[indexPath.section]
        
        if var dog = dogsDict[leagueId]?[indexPath.row] {
            
            TasksService.getTasks(forDog: dog.id, contestId: contest.id, completion: { (error, tasksResponse) in
                
                if let tasks = tasksResponse as? [Task] {
                    dog.tasks = tasks
                    self.dogsDict[leagueId]?[indexPath.row] = dog
                    
                }
                
            })
            
        }
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case let cell as FoldingCell = cell {
            if cellHeights[indexPath.row] == C.CellHeight.close {
                cell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                cell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
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
