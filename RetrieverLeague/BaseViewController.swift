//
//  BaseViewController.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/18/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var titleImage: UIImage? {
        didSet {
            setupTitleView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.view.backgroundColor = UIColor.rlLightGreen
    }

    func setupTitleView() {
        let titleImageView = UIImageView(image: titleImage)
        titleImageView.frame.size = CGSize(width: 200, height: 40)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
