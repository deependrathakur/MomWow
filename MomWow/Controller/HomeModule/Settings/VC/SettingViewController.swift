//
//  SettingViewController.swift
//  MomWow
//
//  Created by Harshit on 17/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
       @IBAction func SignOutAction(sender: UIButton) {
           setRootToMainStoryboard()
       }
}
