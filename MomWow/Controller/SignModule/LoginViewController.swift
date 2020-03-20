//
//  LoginViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: - Button Method extension
fileprivate extension LoginViewController {
    
    @IBAction func loginAction(sender: UIButton) {
        showAlertVC(title: kAlertTitle, message: wip, controller: self)
    }
    
    @IBAction func signUpAction(sender: UIButton) {
        goToNextVC(storyBoardID: mainStoryBoard, vc_id: signUpVC, currentVC: self)
    }
    
    @IBAction func forgotAction(sender: UIButton) {
        goToNextVC(storyBoardID: mainStoryBoard, vc_id: forgotPassword, currentVC: self)
    }
    
    @IBAction func socialAction(sender: UIButton) {
        showAlertVC(title: kAlertTitle, message: wip, controller: self)
    }
}
