//
//  ShareKidsProfileViewController.swift
//  MomWow
//
//  Created by vijay on 14/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ShareKidsProfileViewController: UIViewController {
    
    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var btnViewOnly: UIButton!
    @IBOutlet weak var btnViewAndEdit: UIButton!
    
    var gender = "Male"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnViewOnly.setImage(#imageLiteral(resourceName: "active_check_box"), for: .normal)
        self.btnViewAndEdit.setImage(#imageLiteral(resourceName: "inactive_check_box"), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveAction(sender: UIButton) {
        self.view.endEditing(true)

    }
    
    @IBAction func SelectGender(sender: UIButton) {
        self.view.endEditing(true)
        if sender.tag == 0 {
            gender = "ViewOnly"
            self.btnViewOnly.setImage(#imageLiteral(resourceName: "active_check_box"), for: .normal)
            self.btnViewAndEdit.setImage(#imageLiteral(resourceName: "inactive_check_box"), for: .normal)
        } else {
            gender = "ViewAndEdit"
            self.btnViewOnly.setImage(#imageLiteral(resourceName: "inactive_check_box"), for: .normal)
            self.btnViewAndEdit.setImage(#imageLiteral(resourceName: "active_check_box"), for: .normal)
        }
    }
}
