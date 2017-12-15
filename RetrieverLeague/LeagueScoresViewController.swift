//
//  LeagueScoresViewController.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 12/12/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class LeagueScoresViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var dogs = [Dog]()
    var selectedLeague: League?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.selectedLeague?.name ?? ""
        getDogs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDogs() {
        guard let selectedLeagueId = self.selectedLeague?.id else {
            return
        }
        self.showLoading()
        DogsService.getDogs(leagueId: selectedLeagueId) { (error, dogsResponse) in
            self.hideLoading()
            if error == nil, let dogs = dogsResponse as? [Dog] {
                self.dogs = dogs.sorted(by: { (dog1, dog2) -> Bool in
                    return dog1.totalScore < dog2.totalScore
                });
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.leagueDogCell, for: indexPath) as! DogResultTableViewCell
        
        let dog = dogs[indexPath.row]
        cell.configure(with: dog, index: indexPath.row)
        
        return cell
    }

}
