//
//  LoginViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblCopyRight: UILabel!
    @IBOutlet weak var btnRemember: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Button Method extension
fileprivate extension LoginViewController {
    
    @IBAction func loginAction(sender: UIButton) {
        self.validation()
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

//MARK: - Custome Method extension
fileprivate extension LoginViewController {
    func validation() {
        if self.txtEmailPhone.isEmptyText() {
            self.txtEmailPhone.shakeTextField()
        } else if !self.txtEmailPhone.isValidateEmail() {
            showAlertVC(title: kAlertTitle, message: InvalidEmail, controller: self)
        } else if self.txtPassword.isEmptyText() {
            self.txtPassword.shakeTextField()
        } else {
            let sb: UIStoryboard = UIStoryboard(name: "TabBar", bundle: Bundle.main)
            let navController = sb.instantiateViewController(withIdentifier: "TabBarNav") as? UINavigationController
            UIApplication.shared.keyWindow?.rootViewController = navController
        }
    }
}
