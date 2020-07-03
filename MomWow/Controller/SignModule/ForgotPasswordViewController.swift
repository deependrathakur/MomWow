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
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.stopAnimating()        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendAction(sender: UIButton) {
        self.view.endEditing(true)
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
            self.callAPI()
        }
    }
}


//MARK: - Webservice Method extension
fileprivate extension ForgotPasswordViewController {
    func callAPI() {
        var dict = [String:Any]()
        if txtEmail.isValidateEmail() {
            dict["user[email]"] = self.txtEmail.text ?? ""
        } else {
            dict["user[phone_number]"] = self.txtPhone.text ?? ""
        }
        self.indicator.isHidden = false

        webServiceManager.requestPost(strURL: WebURL.forgot, params: dict, success: { (response) in
            print(response)
            self.indicator.isHidden = true
            if (response["status_code"] as? Int) == 200 {
                 var value = ""
                 if self.txtEmail.isValidateEmail() {
                     value = self.txtEmail.text ?? ""
                                        
                    showAlertWithAction(title: kAlertTitle, message: "A confirmation link has been sent to your email id, please click on the link and reset your password \n'\(self.txtEmail.text ?? "")'" , controller: self, completion: {_ in
                        
                        self.navigationController?.popViewController(animated: true)
                    })
                 } else {
                     value = self.txtPhone.text ?? ""
                    showAlertWithAction(title: kAlertTitle, message: "Your OTP hase been send to your phone number '\(self.txtPhone.text ?? "")'" , controller: self, completion: {_ in
                        
                        self.gotoNextVC(token: response["token"] as? String ?? "", value: value)
                    })
                 }
            } else {
                showAlertVC(title: kAlertTitle, message: response["message"] as? String ?? "" , controller: self)
            }
        }, failure: { (error) in
            self.indicator.isHidden = true
            print(error)
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
    
    func gotoNextVC(token:String, value:String) {
        let vc = UIStoryboard.init(name: mainStoryBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: otpVC) as? OtpViewController
         vc?.otpEmailText = value
         vc?.token = token
         self.navigationController?.pushViewController(vc ?? OtpViewController(), animated: true)
    }
}
