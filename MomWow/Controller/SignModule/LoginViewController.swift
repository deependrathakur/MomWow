//
//  LoginViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var isRememberClicked:Bool = false
    
    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblCopyRight: UILabel!
    @IBOutlet weak var imgRemember: UIImageView!
    @IBOutlet weak var btnRemember: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isRemember = UserDefaults.standard.bool(forKey: UserDefaults.Keys.isRemember)
        if isRemember{
            
            self.txtEmailPhone.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.rememberEmail)
            self.txtPassword.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.rememberPassword)

            self.isRememberClicked = true
            self.imgRemember.layer.borderColor = UIColor.red.cgColor
        }else{
            self.txtEmailPhone.text = ""
            self.txtPassword.text = ""
            self.isRememberClicked = false
            self.imgRemember.layer.borderColor = UIColor.lightGray.cgColor
        }
        self.indicator.stopAnimating()
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
    
    @IBAction func btnRememberAction(sender: UIButton) {
        self.view.endEditing(true)
        
        if self.imgRemember.layer.borderColor == UIColor.lightGray.cgColor{
            self.isRememberClicked = true
            self.imgRemember.layer.borderColor = UIColor.red.cgColor
        }else{
            self.isRememberClicked = false
            self.imgRemember.layer.borderColor = UIColor.lightGray.cgColor
        }
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
        self.indicator.startAnimating()

        webServiceManager.requestPost(strURL: WebURL.Login, params: dict, success: { (response) in
            print(response)
            self.indicator.stopAnimating()
            if (response["status_code"] as? Int) == 200 {
                
                let data = response["data"] as? [String:Any] ?? [:]
                _ = UserModel.init(dict: data)
                
                if self.isRememberClicked{
                    UserDefaults.standard.setValue(true, forKey: UserDefaults.Keys.isRemember)
                    UserDefaults.standard.setValue(self.txtEmailPhone.text ?? "", forKey: UserDefaults.Keys.rememberEmail)
                    UserDefaults.standard.setValue(self.txtPassword.text ?? "", forKey: UserDefaults.Keys.rememberPassword)
                }else{
                    UserDefaults.standard.setValue(false, forKey: UserDefaults.Keys.isRemember)
                    UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.rememberEmail)
                    UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.rememberPassword)
                }
                
                if #available(iOS 13.0, *) {
                    SceneDelegate().gotoTabBar(withAnitmation: true)
                } else {
                    AppDelegate().gotoTabBar(withAnitmation: true)
                }
                //  showAlertVC(title: kAlertTitle, message: response["message"] as? String ?? "" , controller: self)
            } else {
                showAlertVC(title: kAlertTitle, message: response["message"] as? String ?? "" , controller: self)
            }
        }, failure: { (error) in
            self.indicator.stopAnimating()
            print(error)
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
}
