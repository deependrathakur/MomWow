//
//  CartDetailsViewController.swift
//  MomWow
//
//  Created by vijay on 22/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class CartDetailsViewController: UIViewController {
    
    @IBOutlet weak var viewMain: AllCornorsBorderedView!{
        didSet {
            viewMain.borderColor = UIColor.gray
            viewMain.isRounded = true
            viewMain.background = UIColor.white
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let roundRadius:CGFloat = 5
        viewMain.roundedRadius = roundRadius
        DispatchQueue.main.async {
            self.viewMain.addshadow(top: true, left: true, bottom: true, right: true, shadowRadius: 2, shadowColor: UIColor.darkGray, shadowOpecity: 0.4, roundedRadius: 5)
        }
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func becomeMemderAction(sender: UIButton) {
        self.view.endEditing(true)
        
    }
}
