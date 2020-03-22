//
//  ResetPasswordViewController.swift
//  MomWow
//
//  Created by rails on 21/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

//MARK: - Button Method extension
fileprivate extension ResetPasswordViewController {
    
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePasswordAction(sender: UIButton) {
      showAlertVC(title: kAlertTitle, message: wip, controller: self)
    }
}
