//
//  OTPViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//MARK: - Button Method extension
fileprivate extension OTPViewController {
    
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction(sender: UIButton) {
      goToNextVC(storyBoardID: mainStoryBoard, vc_id: resetPassword, currentVC: self)
    }
}
