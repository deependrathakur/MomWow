//
//  EditKidsViewController.swift
//  MomWow
//
//  Created by Vijay sharma on 02/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class AddKidsViewController: UIViewController {
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtMName: UITextField!
    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var datePickerView: UIView!
    @IBOutlet fileprivate weak var datePicker: UIDatePicker!
    @IBOutlet fileprivate weak var datePickerViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.stopAnimating()
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
fileprivate extension AddKidsViewController {
    
    @IBAction private func btnCancelDatePickingAction(sender: UIBarButtonItem) {
        
        self.datePickerViewBottomConstraint.constant = -260
    }
    
    @IBAction private func btnDoneDatePickingAction(sender: UIBarButtonItem) {
        
        self.txtDOB.text = datePicker.date.stringValue(format: "yyyy-MM-dd")
        self.datePickerViewBottomConstraint.constant = -260
    }
    
    @IBAction func selectGenderAction(sender: UIButton) {
        self.view.endEditing(true)
        self.selectGenderAlert()
    }
    
    @IBAction func selectDateAction(sender: UIButton) {
        self.view.endEditing(true)
        self.datePickerViewBottomConstraint.constant = 0
    }
    
    @IBAction func cancelAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveAction(sender: UIButton) {
        self.view.endEditing(true)
        self.validation()
    }
}

//MARK: - Custome Method extension
fileprivate extension AddKidsViewController {
    func validation() {
        self.view.endEditing(true)
        if self.txtFName.isEmptyText() {
            self.txtFName.shakeTextField()
        }
//        else if self.txtMName.isEmptyText() {
//            self.txtMName.shakeTextField()
//        }
        else if self.txtLName.isEmptyText() {
            self.txtLName.shakeTextField()
        }
//        else if self.txtEmailPhone.isEmptyText() {
//            self.txtEmailPhone.shakeTextField()
//        }
//        else if !self.txtEmailPhone.isValidateEmail() {
//            showAlertVC(title: kAlertTitle, message: InvalidEmail, controller: self)
//        }
        else if self.txtDOB.isEmptyText() {
            self.txtDOB.shakeTextField()
        } else if self.txtGender.isEmptyText() {
            self.txtGender.shakeTextField()
        } else {
            callAPI_ForAddKids()
//            postAction()
        }
    }
}

//MARK: - Webservice Method extension
fileprivate extension AddKidsViewController {
    
    func postAction() {
        let Url = String(format: "https://wow-my-kids.herokuapp.com/api/kids")
        guard let serviceUrl = URL(string: Url) else { return }
        
        let name = self.txtFName.text!+" "+self.txtLName.text!
        let parameterDictionary = ["kid[name]":name, "kid[gender]":self.txtGender.text!, "kid[age]":self.txtDOB.text!, "kid[training_type]":"Organizational"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func callAPI_ForAddKids() {
        
        let name = self.txtFName.text!+" "+self.txtLName.text!
        let dict2 = ["kid[name]":name, "kid[gender]":self.txtGender.text!, "kid[age]":self.txtDOB.text!, "kid[training_type]":"Organizational"]
        
        self.indicator.isHidden = false
        webServiceManager.requestPost(strURL: WebURL.addKids, params: dict2, success: { (response) in
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

