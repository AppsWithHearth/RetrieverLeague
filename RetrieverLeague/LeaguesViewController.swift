//
//  LeaguesViewController.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 12/10/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class LeaguesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var leagues = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleImage = #imageLiteral(resourceName: "icon_league")
        getLeagues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - API
    
    func getLeagues() {
        self.showLoading()
        LeaguesService.getLeagues { (error, leaguesResponse) in
            self.hideLoading()
            if error == nil,
                let leagues = leaguesResponse as? [League] {
                self.leagues = leagues
                self.tableView.reloadData()
            }
        }
    }

    //MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.leagueCell, for: indexPath)
        
        let league = self.leagues[indexPath.row]
        
        cell.textLabel?.text = league.name
        
        return cell
    }

}
