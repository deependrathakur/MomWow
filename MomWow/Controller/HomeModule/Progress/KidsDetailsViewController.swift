//
//  KidsDetailsViewController.swift
//  MomWow
//
//  Created by vijay on 26/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class KidsDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnProgressAction(sender: UIButton) {
        self.view.endEditing(true)
        
        goToNextVC(storyBoardID: progressStoryBoard, vc_id: progressGraphViewController, currentVC: self)
    }
}
