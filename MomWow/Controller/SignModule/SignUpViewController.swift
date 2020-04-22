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
    @IBOutlet weak var txtMName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnGenderMale: UIButton!
    @IBOutlet weak var btnGenderFemale: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    @IBOutlet weak var lblCopyRight: UILabel!
    var gender = "Male"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.isHidden = true
        self.btnGenderMale.setImage(#imageLiteral(resourceName: "active_check_box"), for: .normal)
        self.btnGenderFemale.setImage(#imageLiteral(resourceName: "inactive_check_box"), for: .normal)
        // Do any additional setup after loading the view.
    }
}

//MARK: - Button Method extension
fileprivate extension SignUpViewController {
    
    @IBAction func loginAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SignUpAction(sender: UIButton) {
        self.view.endEditing(true)
        self.validation()
    }
    
    @IBAction func SelectGender(sender: UIButton) {
        self.view.endEditing(true)
        if sender.tag == 0 {
            gender = "Male"
            self.btnGenderMale.setImage(#imageLiteral(resourceName: "active_check_box"), for: .normal)
            self.btnGenderFemale.setImage(#imageLiteral(resourceName: "inactive_check_box"), for: .normal)
        } else {
            gender = "Female"
            self.btnGenderMale.setImage(#imageLiteral(resourceName: "inactive_check_box"), for: .normal)
            self.btnGenderFemale.setImage(#imageLiteral(resourceName: "active_check_box"), for: .normal)
        }
    }
}

//MARK: - Custome Method extension
fileprivate extension SignUpViewController {
    func validation() {
        self.view.endEditing(true)
               if self.txtFName.isEmptyText() {
                   self.txtFName.shakeTextField()
               } else if self.txtMName.isEmptyText() {
                    self.txtMName.shakeTextField()
               } else if self.txtLName.isEmptyText() {
                    self.txtLName.shakeTextField()
               } else if self.txtEmailPhone.isEmptyText() {
                   self.txtEmailPhone.shakeTextField()
               } else if !self.txtEmailPhone.isValidateEmail() {
                   showAlertVC(title: kAlertTitle, message: InvalidEmail, controller: self)
               } else if self.txtPhone.isEmptyText() {
                    self.txtPhone.shakeTextField()
               } else if self.txtPassword.isValidateEmail() {
                   self.txtPassword.shakeTextField()
               } else if self.txtPassword.isValidateEmail() {
                   self.txtPassword.shakeTextField()
               } else {
                callAPI_ForRegister()
        }
    }
}

//MARK: - Webservice Method extension
fileprivate extension SignUpViewController {
    func callAPI_ForRegister() {
        
        let dict2 = ["user[email]":(txtEmailPhone.isValidateEmail() == true) ? (txtEmailPhone.text ?? "") : "",
        "user[password]":self.txtPassword.text ?? "",
        "user[middle_name]":self.txtMName.text ?? "",
        "user[last_name]":self.txtLName.text ?? "",
        "user[gender]":self.gender,
        "user[phone_number]":self.txtPhone.text ?? "",
        "user[user_type]":"admin",
        "user[first_name]":self.txtFName.text ?? ""]
        self.indicator.isHidden = false
        webServiceManager.requestPost(strURL: WebURL.SignUp, params: dict2, success: { (response) in
            print(response)
            self.indicator.isHidden = true
            if let dict =  response["user"] as? [String:Any] {
                showAlertVC(title: kAlertTitle, message: dict["messages"] as? String ?? "", controller: self)
            }
        }, failure: { (error) in
            print(error)
            self.indicator.isHidden = true
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
}
