//
//  SignUpViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtMName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnGenderMale: UIButton!
    @IBOutlet weak var btnGenderFemale: UIButton!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    @IBOutlet weak var lblCopyRight: UILabel!
    var gender = "Male"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.stopAnimating()
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
    
    @IBAction func btnShowHidePasswordAction(sender: UIButton) {
        self.view.endEditing(true)
        
        if self.btnShowHidePassword.image(for: .normal) == UIImage(named: "eyeIconClose"){
            self.txtPassword.isSecureTextEntry = false
            self.btnShowHidePassword.setImage(UIImage(named: "eyeOpen"), for: .normal)
        }else{
            self.txtPassword.isSecureTextEntry = true
            self.btnShowHidePassword.setImage(UIImage(named: "eyeIconClose"), for: .normal)
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
        } else if self.txtPassword.isEmptyText() {
            self.txtPassword.shakeTextField()
        } else if self.txtPassword.text!.count < 6 {
            showAlertVC(title: kAlertTitle, message: InvalidPassword, controller: self)
        } else {
            callAPI_ForRegister()
        }
    }
}

//MARK: - Webservice Method extension
fileprivate extension SignUpViewController {
    
    func callAPI_ForRegister(){
        
        let urlDict = "user[email]=\(self.txtEmailPhone.text!)&user[password]=\(self.txtPassword.text!)&user[middle_name]=\(self.txtMName.text!)&user[last_name]=\(self.txtLName.text!)&user[gender]=\(self.gender)&user[phone_number]=\(self.txtPhone.text!)&user[user_type]=admin&user[type]=Parent&user[first_name]=\(self.txtFName.text!)&user[status]=active"

        let urlString = WebURL.SignUp+urlDict
        
        let newURL = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let searchURL = URL(string: newURL ?? "")
        
        self.indicator.isHidden = false
        AF.request(searchURL!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response.result)

            switch response.result {

            case .success(_):
                self.indicator.isHidden = true
                if let json = response.value
                {
                    let dict = json as? [String:Any]
                    if let user = dict?["user"] as? [String:Any] {
                    let msg = user["messages"] as? String
                    showAlertWithAction(title: kAlertTitle, message: (msg ?? "confirmation link sent to")+"\n\(self.txtEmailPhone.text!)" , controller: self, completion: {_ in
                    self.navigationController?.popViewController(animated: true)    })
                    
                    } else {
                        
                        if let errors = dict?["errors"] as? [String:Any] {
                            if let errors = errors["email"] as? [String] {
                                showAlertVC(title: kAlertTitle, message: errors[0], controller: self)
                            } else {
                                showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
                            }
                        } else {
                            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
                        }
                    }
                }else{
                    showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
                }
                break
            case .failure(let error):
                print(error)
                self.indicator.isHidden = true
                showAlertVC(title: kAlertTitle, message: error.localizedDescription, controller: self)
                break
            }
        }
    }
}
