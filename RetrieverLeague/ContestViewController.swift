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
        dogsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dogsDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(dogsDict.keys)[section]
        return dogsDict[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogCell", for: indexPath)
        
        cell.textLabel?.text = "Test"
        
        return cell
    }

}
