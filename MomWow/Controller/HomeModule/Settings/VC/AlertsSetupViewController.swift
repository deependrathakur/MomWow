//
//  AlertsSetupViewController.swift
//  MomWow
//
//  Created by vijay on 06/06/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class AlertsSetupViewController: UIViewController {
    @IBOutlet weak var lblPrimaryNo: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblActivityReminder: UITextField!
    @IBOutlet weak var lblBillPaymentReminder: UITextField!

    @IBOutlet weak var imgSMS: UIImageView!
    @IBOutlet weak var imgFB: UIImageView!
    @IBOutlet weak var imgWhatAapp: UIImageView!

    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var viewPicker: UIView!
    private var isActivity = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewPicker.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectDateAction(sender: UIButton) {
        self.view.endEditing(true)
        
        if sender.tag == 1 {//ActivityReminder
            self.isActivity = true
            self.viewPicker.isHidden = false
        } else if sender.tag == 2 {//BillPaymentReminder
            self.isActivity = false
            self.viewPicker.isHidden = false
        } else if sender.tag == 3 {//SMS Alert
            self.imgSMS.setImageInAlert()
        } else if sender.tag == 4 {//FB Alert
            self.imgFB.setImageInAlert()
        } else if sender.tag == 5 {//What'sApp Alert
            self.imgWhatAapp.setImageInAlert()
        } else if sender.tag == 6 {//Done Date
            self.selectDate(isSelect: true)
        } else if sender.tag == 7 {//Cancel Alert
            self.selectDate(isSelect: false)
        } else if sender.tag == 8 {//Candel Update detail
            self.navigationController?.popViewController(animated: true)
        } else if sender.tag == 9 {//Update detail
            showAlertVC(title: "Alert", message: wip, controller: self)
        } else {
            
        }
    }
    
    func selectDate(isSelect: Bool) {
        if isActivity && isSelect {
            self.lblActivityReminder.text = crtToDateString(crd: String(describing: self.picker.date))
        } else if !isActivity && isSelect {
            self.lblBillPaymentReminder.text = crtToDateString(crd: String(describing: self.picker.date))
        }
        self.viewPicker.isHidden = true
    }
    
}

extension UIImageView {
    func setImageInAlert() {
        if self.image == #imageLiteral(resourceName: "switchInactive") {
            self.image = #imageLiteral(resourceName: "switchGreen")
        } else {
            self.image = #imageLiteral(resourceName: "switchInactive")
        }
    }
}
