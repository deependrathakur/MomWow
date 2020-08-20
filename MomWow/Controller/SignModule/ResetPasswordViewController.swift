//
//  ResetPasswordViewController.swift
//  MomWow
//
//  Created by rails on 21/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

//MARK: - Custome Method extension
fileprivate extension ResetPasswordViewController {
    func validation() {
        self.view.endEditing(true)
        if self.txtNewPassword.isEmptyText() {
            self.txtNewPassword.shakeTextField()
        } else if self.txtNewPassword.text!.count < 6 {
            showAlertVC(title: kAlertTitle, message: InvalidPassword, controller: self)
        } else if self.txtConfirmPassword.isEmptyText() {
            self.txtConfirmPassword.shakeTextField()
        } else if self.txtConfirmPassword.isEmptyText() {
            showAlertVC(title: kAlertTitle, message: MismatchPassword, controller: self)
        } else {
            self.navigationController?.popToViewController(LoginViewController(), animated: true)
        }
    }
}
