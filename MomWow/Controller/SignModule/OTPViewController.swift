//
//  OTPViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblTitleEmail_Phone: UILabel!
    @IBOutlet weak var lblOTP_Phone: UIButton!
    @IBOutlet weak var txtOtp1: UITextField!
    @IBOutlet weak var txtOtp2: UITextField!
    @IBOutlet weak var txtOtp3: UITextField!
    @IBOutlet weak var txtOtp4: UITextField!
    
    var otpEmailText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageView()
        self.txtOtp1.delegate = self
        self.txtOtp2.delegate = self
        self.txtOtp3.delegate = self
        self.txtOtp4.delegate = self
    }
}

//MARK: - Button Method extension
fileprivate extension OTPViewController {
    
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction(sender: UIButton) {
        self.validation()
    }
}

//MARK: - Custome Method extension
fileprivate extension OTPViewController {
    
    func manageView() {
        if otpEmailText.isValidateEmail() {
            self.lblTitleEmail_Phone.text = "We have send an OTP on your Email"
            self.lblOTP_Phone.setTitle("email \(otpEmailText) ", for: .normal)
        } else {
            self.lblTitleEmail_Phone.text = "We have send an OTP on your Mobile"
            self.lblOTP_Phone.setTitle("number \(otpEmailText) ", for: .normal)
        }
    }
    
    func validation() {
        self.view.endEditing(true)
        if self.txtOtp1.isEmptyText() {
            self.txtOtp1.shakeTextField()
        } else if self.txtOtp2.isEmptyText() {
            self.txtOtp2.shakeTextField()
        } else if self.txtOtp3.isEmptyText() {
            self.txtOtp3.shakeTextField()
        } else if self.txtOtp4.isEmptyText() {
            self.txtOtp4.shakeTextField()
        } else {
           goToNextVC(storyBoardID: mainStoryBoard, vc_id: resetPassword, currentVC: self)
        }
    }
}


//MARK: - textfieldDelegate method
extension OTPViewController {
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        _ = textField.text! as NSString
        var searchString: String? = nil
        if textField == self.txtOtp1 {
            if string.count > 0 {
                searchString = (string).uppercased()
            } else {
                searchString = ((txtOtp1.text as NSString?)?.substring(to: (txtOtp1.text?.count)! - 1))?.uppercased()
            }
            if (searchString?.count ?? 0) >= 1 {
                if (searchString?.count ?? 0) == 1 {
                    txtOtp1.text = searchString
                }
                searchString = nil
                txtOtp2.becomeFirstResponder()
                return false
            } else {
                
            }
        } else if textField == self.txtOtp2 {
            if string.count > 0 {
                searchString = (string).uppercased()
            } else {
                searchString = ((txtOtp2.text as NSString?)?.substring(to: (txtOtp2.text?.count)! - 1))?.uppercased()
            }
            if (searchString?.count ?? 0) >= 1 {
                if (searchString?.count ?? 0) == 1 {
                    txtOtp2.text = searchString
                }
                searchString = nil
                txtOtp3.becomeFirstResponder()
                return false
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                    self.txtOtp1.becomeFirstResponder()
                }
            }
        }else if textField == self.txtOtp3 {
            if string.count > 0 {
                searchString = (string).uppercased()
            } else {
                searchString = ((txtOtp3.text as NSString?)?.substring(to: (txtOtp3.text?.count)! - 1))?.uppercased()
            }
            if (searchString?.count ?? 0) >= 1 {
                if (searchString?.count ?? 0) == 1 {
                    txtOtp3.text = searchString
                }
                searchString = nil
                txtOtp4.becomeFirstResponder()
                return false
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                    self.txtOtp2.becomeFirstResponder()
                }
            }
        }else if textField == self.txtOtp4 {
            if string.count > 0 {
                searchString = (string).uppercased()
            } else {
                searchString = ((txtOtp4.text as NSString?)?.substring(to: (txtOtp4.text?.count)! - 1))?.uppercased()
            }
            if (searchString?.count ?? 0) >= 1 {
                if (searchString?.count ?? 0) == 1 {
                    txtOtp4.text = searchString
                }
                searchString = nil
                txtOtp4.resignFirstResponder()
                return false
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                    self.txtOtp3.becomeFirstResponder()
                }
            }
        }
        return  true
    }
}
