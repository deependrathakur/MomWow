//
//  AlertsSetupViewController.swift
//  MomWow
//
//  Created by vijay on 06/06/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class AlertsSetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}
