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
    @IBOutlet weak var lblAddKidsProfile: UILabel!
    @IBOutlet weak var imgUserProfile:UIImageView!

    @IBOutlet private weak var datePickerView: UIView!
    @IBOutlet fileprivate weak var datePicker: UIDatePicker!
    @IBOutlet fileprivate weak var datePickerViewBottomConstraint: NSLayoutConstraint!
    var addKids = true
    var kidsDetail = ModelKidsDetail(dict: [:])
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.stopAnimating()
        self.parseData()
    }
    
    func parseData() {
        self.lblAddKidsProfile.text = "Add Kids Profile"
        if !addKids {
            self.lblAddKidsProfile.text = "Update Kids Profile"

            self.txtDOB.text = kidsDetail.age
            self.txtGender.text = kidsDetail.gender
            self.txtEmailPhone.text = kidsDetail.email
            let fullName = kidsDetail.name.components(separatedBy: " ")
            if fullName.count > 2{
                self.txtFName.text = fullName[0]
                self.txtMName.text = fullName[1]
                self.txtLName.text = fullName[2]
            } else if fullName.count > 1 {
                self.txtFName.text = fullName[0]
                self.txtMName.text = fullName[1]
                self.txtLName.text = ""
            } else {
                self.txtFName.text = fullName[0]
                self.txtMName.text = ""
                self.txtLName.text = ""
            }
        }
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
        } else if self.txtMName.isEmptyText() {
            self.txtMName.shakeTextField()
        } else if self.txtLName.isEmptyText() {
            self.txtLName.shakeTextField()
        } else if self.txtEmailPhone.isEmptyText() {
            self.txtEmailPhone.shakeTextField()
        } else if !self.txtEmailPhone.isValidateEmail() {
            showAlertVC(title: kAlertTitle, message: InvalidEmail, controller: self)
        } else if self.txtDOB.isEmptyText() {
            self.txtDOB.shakeTextField()
        } else if self.txtGender.isEmptyText() {
            self.txtGender.shakeTextField()
        } else {
            if addKids {
                callAPI_ForAddKids()
            } else {
                callAPI_ForUpdateKids()
            }
        } 
    }
}

//MARK: - Webservice Method extension
fileprivate extension AddKidsViewController {
    
    func callAPI_ForAddKids() {
        
        var image:NSData?
        if let imageData: NSData = imgUserProfile.image?.pngData() as NSData? {
            image = imageData
        }
        
        let name = self.txtFName.text!+" "+self.txtMName.text!+" "+self.txtLName.text!
        let parentId = UserDefaults.standard.value(forKey: UserDefaults.Keys.id) as? Int ?? 0
        let kids = ["name": "\(name)",
            "age": "\(self.txtDOB.text ?? "")",
            "parent_id": "\(parentId)",
            "gender": "\(self.txtGender.text ?? "")",
           // "attachment": image,
            "email": "\(self.txtEmailPhone.text ?? "")"] as [String : Any]
        let dict = ["kid": kids]
        
        self.indicator.isHidden = false
        webServiceManager.requestPost2(strURL: WebURL.addKids, params: dict, success: { (response) in
            print(response) 
            self.indicator.isHidden = true
            if (response["status_code"] as? Int) == 200 {
                 showAlertVC_Back(title: kAlertTitle, message: response["message"] as? String ?? "", controller: self)
            } else if (response["status_code"] as? Int) == 500 {
                if let message = response["message"] as? [String], message.count > 0 {
                    showAlertVC(title: kAlertTitle, message: message[0] as? String ?? kErrorMessage, controller: self)
                } else {
                    showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
                }
            } else {
                showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
            }
        }, failure: { (error) in
            print(error)
            self.indicator.isHidden = true
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
    
    func callAPI_ForUpdateKids() {

        let name = self.txtFName.text! + " " + self.txtMName.text! + " " + self.txtLName.text!
        let parentId = UserDefaults.standard.value(forKey: UserDefaults.Keys.id) as? Int ?? 0
        let kids = ["name": "\(name)",
            "age": "\(self.txtDOB.text ?? "")",
            "parent_id": "\(parentId)",
            "gender": "\(self.txtGender.text ?? "")",
            "email": "\(self.txtEmailPhone.text ?? "")"]
        let dict = ["kid": kids]
        
        self.indicator.isHidden = false
        webServiceManager.requestPut(strURL: WebURL.updateKids+kidsDetail.id, params: dict, success: { (response) in
            print(response)
            self.indicator.isHidden = true
            if (response["status_code"] as? Int) == 200 {
                 showAlertVC_Back(title: kAlertTitle, message: response["message"] as? String ?? "", controller: self)
            } else if let dict =  response["errors"] as? [String:Any] {
                showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
            }
        }, failure: { (error) in
            print(error)
            self.indicator.isHidden = true
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
}

//MARK: - image picker extension
extension AddKidsViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBAction func imageAction(sender: UIButton) {
        self.view.endEditing(true)
        self.selectProfileImage()
    }
    
    func selectProfileImage() {
        let selectImage = UIAlertController(title: "Select Profile Image", message: nil, preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let btn0 = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        })
        let btn1 = UIAlertAction(title: "Camera", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                imagePicker.showsCameraControls = true
                imagePicker.allowsEditing = true;
                self.present(imagePicker, animated: true)
            }
        })
        let btn2 = UIAlertAction(title: "Photo Library", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true;
                self.present(imagePicker, animated: true)
            }
        })
        selectImage.addAction(btn0)
        selectImage.addAction(btn1)
        selectImage.addAction(btn2)
        present(selectImage, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imgUserProfile.image = newImage
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
