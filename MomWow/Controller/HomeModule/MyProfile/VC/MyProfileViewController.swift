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
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgUserProfile:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureProfileData()
        self.indicator.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentTabIndex == 0 {
            self.btnBack.isHidden = false
        } else {
            self.btnBack.isHidden = true
        }
    }
    
    @IBAction func backAction(sender: UIButton) {
        self.view.endEditing(true)
        self.self.navigationController?.popViewController(animated: true)
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
    
    func callAPI_ForUpdateProfile1(){
        parent
        let urlDict = "parent[email]=\(self.txtEmailPhone.text!)& parent[middle_name]=\(self.txtLName.text!)& parent[last_name]=\(self.txtLName.text!)&parent[gender]=\(self.txtGender.text!)&parent[status]=Active&parent[phone_number]=\(self.txtPhone.text!)&parent[user_type]=admin&parent[first_name]=\(self.txtFName.text!)"

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
    
    func callAPI_ForUpdateProfile() {
        
        let dict2 = ["parent[email]": self.txtEmailPhone.text!, "parent[middle_name]":self.txtLName.text!, "parent[last_name]":self.txtLName.text!, "parent[gender]":self.txtGender.text!, "parent[status]":"Active",  "parent[phone_number]":self.txtPhone.text!, "parent[user_type]":"admin", "parent[first_name]":self.txtFName.text!]
  
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


//MARK: - image picker extension
extension MyProfileViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {

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
