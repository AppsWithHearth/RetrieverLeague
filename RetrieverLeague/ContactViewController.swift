//
//  ContactViewController.swift
//  RetrieverLeague
//
//  Created by Uros Zivaljevic on 7/18/17.
//  Copyright © 2017 Uros Zivaljevic. All rights reserved.
//

import UIKit

class ContactViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleImage = #imageLiteral(resourceName: "icon_contact")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
 
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
            !messageTextView.text.isEmpty else {
                ErrorHelper.showAlert(title: "Error", message: "Please fill out all fields.", from: self)
                return
        }
        
        self.showLoading()
        MessagesService.sendContactMessage(email: email, message: messageTextView.text) { (error, messageResponse) in
            self.hideLoading()
        }
    }
    

}
