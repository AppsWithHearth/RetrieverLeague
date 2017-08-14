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
        static let close: CGFloat = 50 // equal or greater foregroundView height
        static let open: CGFloat = 100 // equal or greater containerView height
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
    var cellHeights = [Int: [CGFloat]]()
    
    @IBOutlet weak var dogsTableView: UITableView! {
        didSet {
            dogsTableView.delegate = self
            dogsTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, dog) in contest.dogs.enumerated() {
            if dogsDict[dog.leagueId] == nil {
                dogsDict[dog.leagueId] = [Dog]()
                cellHeights[index] = [CGFloat]()
            }
            cellHeights[index]?.append(C.CellHeight.close)
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
        return cellHeights[indexPath.section]?[indexPath.row] ?? C.CellHeight.close
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
        
        let cell = tableView.cellForRow(at: indexPath) as! ContestDogTableViewCell
        
        let leagueId = dogCategories[indexPath.section]
        
        if var dog = dogsDict[leagueId]?[indexPath.row] {
            
            if dog.tasks != nil {
                self.animateCell(cell: cell, indexPath: indexPath)
            } else {
                cell.showLoading()
                TasksService.getTasks(forDog: dog.id, contestId: contest.id, completion: { (error, tasksResponse) in
                    cell.hideLoading()
                    if let tasks = tasksResponse as? [Task] {
                        dog.tasks = tasks
                        self.dogsDict[leagueId]?[indexPath.row] = dog
                        cell.tasks = tasks
                        self.animateCell(cell: cell, indexPath: indexPath)
                    }
                    
                })
            }
        }
        
    }
    
    func getTasks(for dog: Dog) {
        
    }
    
    func animateCell(cell: FoldingCell, indexPath: IndexPath) {
        var duration = 0.0
        let cellHeight = cellHeights[indexPath.section]?[indexPath.row] ?? C.CellHeight.close
        if cellHeight == C.CellHeight.close { // open cell
            cellHeights[indexPath.section]?[indexPath.row] = C.CellHeight.open
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.section]?[indexPath.row] = C.CellHeight.close
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.5
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
            self.dogsTableView.beginUpdates()
            self.dogsTableView.endUpdates()
        }, completion: nil)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case let cell as FoldingCell = cell,
            let cellHeight = cellHeights[indexPath.section]?[indexPath.row] {
            if cellHeight == C.CellHeight.close {
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
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 0.075, green: 0.486, blue: 0.267, alpha: 1.00)
        
        
        let leagueNameLabel = UILabel()
        headerView.addSubview(leagueNameLabel)
        leagueNameLabel.text = LeagueHelper.categoryName(for: dogCategories[section])
        leagueNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        leagueNameLabel.textColor = .white
        
        leagueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        leagueNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8).isActive = true
        leagueNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 8).isActive = true
        leagueNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        return headerView
        
    }
    
}
