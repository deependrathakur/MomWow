//
//  MyProfileViewController.swift
//  MomWow
//
//  Created by Vijay sharma on 02/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit
import Alamofire

class MyProfileViewController: UIViewController {
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtMName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureProfileData()
        self.indicator.stopAnimating()
    }
    
    func configureProfileData(){
        
        self.txtFName.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.first_name) ?? ""
        self.txtMName.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.middle_name) ?? ""
        self.txtLName.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.last_name) ?? ""
        self.txtEmailPhone.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.email) ?? ""
        self.txtPhone.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.phone_number) ?? ""
        self.txtGender.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.gender) ?? ""

    }
    
    //MARK: IBAction
        func selectGenderAlert() {
           
           let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
           
           controller.addAction(UIAlertAction(title: "Male", style: .default, handler: { [weak self] (action) in
               
               self?.txtGender.text = "Male"
           }))
           
           controller.addAction(UIAlertAction(title: "Female", style: .default, handler: { [weak self] (action) in
               
               self?.txtGender.text = "Female"
           }))
           
           if let ppc = controller.popoverPresentationController {
               ppc.barButtonItem = navigationItem.rightBarButtonItem
           }
           present(controller, animated: true, completion: nil)
       }
}

//MARK: - Button Method extension
fileprivate extension MyProfileViewController {
    
    @IBAction func selectGenderAction(sender: UIButton) {
        self.view.endEditing(true)
        self.selectGenderAlert()
    }
    
    @IBAction func cancelAction(sender: UIButton) {
        self.view.endEditing(true)
        selectedTabIndex = 4
        AppDelegate().gotoTabBar(withAnitmation: true, isTypeLeft:true)
    }
    
    @IBAction func saveAction(sender: UIButton) {
        self.view.endEditing(true)
        self.validation()
    }
}

//MARK: - Custome Method extension
fileprivate extension MyProfileViewController {
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
        } else if self.txtGender.isEmptyText() {
            self.txtGender.shakeTextField()
        } else {
//            postAction()
            callAPI_ForUpdateProfile()
        }
    }
}

//MARK: - Webservice Method extension
fileprivate extension MyProfileViewController {
    
    func callAPI_ForUpdateProfile(){
                
        let urlDict = "user[email]=\(self.txtEmailPhone.text!)& user[middle_name]=\(self.txtLName.text!)& user[last_name]=\(self.txtLName.text!)&user[gender]=\(self.txtGender.text!)&user[status]=Active&user[phone_number]=\(self.txtPhone.text!)&user[user_type]=admin&user[first_name]=\(self.txtFName.text!)"

        let urlString = WebURL.updateProfile+urlDict
        
        let newURL = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let searchURL = URL(string: newURL ?? "")
        
        self.indicator.isHidden = false
        AF.request(searchURL!, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response.result)

            switch response.result {

            case .success(_):
                self.indicator.isHidden = true
                if let json = response.value
                {
                    print(json)
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
    
    func callAPI_ForUpdateProfile1() {
        
        let dict2 = ["user[email]": self.txtEmailPhone.text!, "user[middle_name]":self.txtLName.text!, "user[last_name]":self.txtLName.text!, "user[gender]":self.txtGender.text!, "user[status]":"Active",  "user[phone_number]":self.txtPhone.text!, "user[user_type]":"admin", "user[first_name]":self.txtFName.text!]
        self.indicator.isHidden = false
        webServiceManager.requestPatch(strURL: WebURL.updateProfile, params: dict2, success: { (response) in
            print(response)
            self.indicator.isHidden = true
            if let dict =  response["user"] as? [String:Any] {
                AppDelegate().gotoTabBar(withAnitmation: true)
                // showAlertVC(title: kAlertTitle, message: dict["messages"] as? String ?? "", controller: self)
            } else if let dict =  response["errors"] as? [String:Any] {
                if let email = dict["email"] as? String {
                    showAlertVC(title: kAlertTitle, message: "Email has already registered", controller: self)
                } else {
                    showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
                }
            }
        }, failure: { (error) in
            print(error)
            self.indicator.isHidden = true
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
}
