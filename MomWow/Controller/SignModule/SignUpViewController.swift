//
//  SignUpViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//MARK: - Button Method extension
fileprivate extension SignUpViewController {
    
    @IBAction func loginAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SignUpAction(sender: UIButton) {
      showAlertVC(title: kAlertTitle, message: PRS, controller: self)
    }
}
