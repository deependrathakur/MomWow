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
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.isHidden = true
    }
}

//MARK: - Button Method extension
fileprivate extension LoginViewController {
    
    @IBAction func loginAction(sender: UIButton) {
        self.view.endEditing(true)
        self.validation()
    }
    
    @IBAction func signUpAction(sender: UIButton) {
        self.view.endEditing(true)
        goToNextVC(storyBoardID: mainStoryBoard, vc_id: signUpVC, currentVC: self)
    }
    
    @IBAction func forgotAction(sender: UIButton) {
        self.view.endEditing(true)
        goToNextVC(storyBoardID: mainStoryBoard, vc_id: forgotPassword, currentVC: self)
    }
    
    @IBAction func socialAction(sender: UIButton) {
        self.view.endEditing(true)
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
            callAPI_ForLogin()
        }
    }
}

//MARK: - Webservice Method extension
fileprivate extension LoginViewController {
    func callAPI_ForLogin() {
        
        let dict = ["user[email]":(txtEmailPhone.isValidateEmail() == true) ? (txtEmailPhone.text ?? "") : "",
                    "user[password]":self.txtPassword.text ?? "",
                    "user[phone_number]":(txtEmailPhone.isValidateEmail() == true) ? "" : (txtEmailPhone.text ?? ""),
                    "user[user_type]":"admin"]
        self.indicator.isHidden = false

        webServiceManager.requestPost(strURL: WebURL.Login, params: dict, success: { (response) in
            print(response)
            self.indicator.isHidden = true
            if (response["status_code"] as? Int) == 200 {
                UserDefaults.standard.setValue(response["data"] as? [String:Any], forKey: "userDetails")
                UserDefaults.standard.setValue(true, forKey: "isLogin")
                UserDefaults.standard.setValue(response["token"] as? String ?? "", forKey: "authToken")
                AppDelegate().gotoTabBar(withAnitmation: true)
              //  showAlertVC(title: kAlertTitle, message: response["message"] as? String ?? "" , controller: self)
            } else {
                showAlertVC(title: kAlertTitle, message: response["message"] as? String ?? "" , controller: self)
            }
        }, failure: { (error) in
            self.indicator.isHidden = true
            print(error)
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
}
