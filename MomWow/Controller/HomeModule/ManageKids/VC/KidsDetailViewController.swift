//
//  EditKidsViewController.swift
//  MomWow
//
//  Created by Vijay sharma on 03/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class KidsDetailViewController: UIViewController {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblGender:UILabel!
    @IBOutlet weak var lblOrganization:UILabel!
    @IBOutlet weak var lblTitle:UILabel!

    @IBOutlet weak var lblHeader:UILabel!
    @IBOutlet weak var imgProfile:UIImageView!
    
    @IBOutlet weak var lblLabel:UILabel!
    @IBOutlet weak var imgLavel:UIImageView!
    
    @IBOutlet weak var lblActivity:UILabel!
    @IBOutlet weak var imgActivity:UIImageView!
    
    @IBOutlet weak var lblTrainer:UILabel!
    @IBOutlet weak var imgTrainer:UIImageView!
    
    var modelKidsDetail =  ModelKidsDetail(dict: [:])
    var modelProvider = ModelProviderList(dict: [:])

    @IBOutlet weak var viewMain: AllCornorsBorderedView!{
        didSet {
            viewMain.borderColor = UIColor.lightGray
            viewMain.isRounded = true
            viewMain.background = UIColor.white

            let roundRadius:CGFloat = 5
            viewMain.roundedRadius = roundRadius
            DispatchQueue.main.async {
                self.viewMain.addshadow(top: true, left: true, bottom: true, right: true, shadowRadius: 2, shadowColor: UIColor.lightGray, shadowOpecity: 0.3, roundedRadius: roundRadius)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblName.text = modelKidsDetail.name
        self.lblHeader.text = modelKidsDetail.name
        self.lblGender.text = "\(modelKidsDetail.age) Year  ● \(modelKidsDetail.gender.capitalized)"
        if modelProvider != nil  {
            self.lblOrganization.text = self.modelProvider.name
        }
        self.lblTitle.text = "Training"//modelKidsDetail.name
        self.lblLabel.text = "Frog"//modelKidsDetail.name
        self.lblActivity.text = "Swimming"//modelKidsDetail.name
        self.lblTrainer.text = "Navin"//modelKidsDetail.name
        // Do any additional setup after loading the view.
    }
   
    @IBAction func btnShareAction(sender: UIButton) {
        self.view.endEditing(true)
        goToNextVC(storyBoardID: manageKidsStoryBoard, vc_id: shareKidsProfileViewController, currentVC: self)
    }
    
    @IBAction func btnEditAction(sender: UIButton) {
        let storyboard = UIStoryboard.init(name: manageKidsStoryBoard, bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: addKidsViewController) as? AddKidsViewController {
            vc.addKids = false
            vc.kidsDetail = modelKidsDetail
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnDeleteAction(sender: UIButton) {
        showAlertVC(title: kAlertTitle, message: wip, controller: self)
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}
