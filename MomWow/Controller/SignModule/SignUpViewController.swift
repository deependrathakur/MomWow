//
//  SignUpViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!

    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblCopyRight: UILabel!
    
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
        self.validation()
    }
}

//MARK: - Custome Method extension
fileprivate extension SignUpViewController {
    func validation() {
        self.view.endEditing(true)
               if self.txtFName.isEmptyText() {
                   self.txtFName.shakeTextField()
               }  else if self.txtLName.isEmptyText() {
                 self.txtLName.shakeTextField()
               } else if self.txtEmailPhone.isEmptyText() {
                   self.txtEmailPhone.shakeTextField()
               } else if !self.txtEmailPhone.isValidateEmail() {
                   showAlertVC(title: kAlertTitle, message: InvalidEmail, controller: self)
               } else if self.txtPassword.isValidateEmail() {
                   self.txtPassword.shakeTextField()
               } else if self.txtPassword.isValidateEmail() {
                   self.txtPassword.shakeTextField()
               } else {
                let sb: UIStoryboard = UIStoryboard(name: "TabBar", bundle: Bundle.main)
                let navController = sb.instantiateViewController(withIdentifier: "TabBarNav") as? UINavigationController
                UIApplication.shared.keyWindow?.rootViewController = navController
        }
    }
}
