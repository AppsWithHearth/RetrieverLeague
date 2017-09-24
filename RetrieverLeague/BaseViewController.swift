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
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLoadingIndicator()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.view.backgroundColor = UIColor.rlLightGreen
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupTitleView() {
        let titleImageView = UIImageView(image: titleImage)
        titleImageView.frame.size = CGSize(width: 200, height: 40)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    
    func setupLoadingIndicator() {
        self.view.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
   
    func showLoading(color: UIColor = .white) {
        loadingIndicator.color = color
        loadingIndicator.startAnimating()
        self.view.bringSubview(toFront: loadingIndicator)
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    

}
