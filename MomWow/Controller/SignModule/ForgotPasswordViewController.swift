//
//  ForgotPasswordViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendAction(sender: UIButton) {
        self.validation()
    }
    
}

//MARK: - Custome Method extension
fileprivate extension ForgotPasswordViewController {
    func validation() {
        self.view.endEditing(true)
        if self.txtEmail.isEmptyText() && self.txtPhone.isEmptyText() {
           showAlertVC(title: kAlertTitle, message: "Please enter email or phone number.", controller: self)
        } else if !self.txtEmail.isEmptyText() && !self.txtEmail.isValidateEmail() {
           showAlertVC(title: kAlertTitle, message: InvalidEmail, controller: self)
        } else {
           goToNextVC(storyBoardID: mainStoryBoard, vc_id: otpVC, currentVC: self)
        }
    }
}

