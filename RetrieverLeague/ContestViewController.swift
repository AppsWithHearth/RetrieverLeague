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
    var dogLeagues = [League]()
    var cellHeights = [Int: [CGFloat]]()
    
    @IBOutlet weak var dogsTableView: UITableView! {
        didSet {
            dogsTableView.delegate = self
            dogsTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for dog in contest.dogs {
            if dogsDict[dog.league.id] == nil {
                dogsDict[dog.league.id] = [Dog]()
                dogLeagues.append(dog.league)
            }
            dogsDict[dog.league.id]?.append(dog)
        }
        
        var index = 0
        for league in dogLeagues {
//            cellHeights[index] = [CGFloat]()
            cellHeights[index] = dogsDict[league.id]?.map { _ in return C.CellHeight.close }
            index += 1
        }
        
        dogsTableView.reloadData()
    }    

    //MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dogLeagues.count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = dogLeagues[section].id
        return dogsDict[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.section]?[indexPath.row] ?? C.CellHeight.close
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.contestDogCell, for: indexPath) as! ContestDogTableViewCell
        
        let leagueId = dogLeagues[indexPath.section].id
        if let dog = dogsDict[leagueId]?[indexPath.row] {
            
            cell.configure(with: dog, index: indexPath.row)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ContestDogTableViewCell
        
        let leagueId = dogLeagues[indexPath.section].id
        
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
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.section]?[indexPath.row] = C.CellHeight.close
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.5
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { 
            self.dogsTableView.beginUpdates()
            self.dogsTableView.endUpdates()
        }, completion: nil)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case let cell as FoldingCell = cell,
            let cellHeight = cellHeights[indexPath.section]?[indexPath.row] {
            if cellHeight == C.CellHeight.close {
                cell.unfold(false, animated: false, completion:nil)
            } else {
                cell.unfold(true, animated: false, completion: nil)
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
        leagueNameLabel.text = dogLeagues[section].name
        leagueNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        leagueNameLabel.textColor = .white
        
        leagueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        leagueNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8).isActive = true
        leagueNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 8).isActive = true
        leagueNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        return headerView
        
    }
    
}
