//
//  ManageKidsViewController.swift
//  MomWow
//
//  Created by Harshit on 17/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ManageKidsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblAgeGender:UILabel!
    @IBOutlet weak var lblSharedBy:UILabel!
    @IBOutlet weak var imgProfile:UIImageView!
    
    var updateKidsHandler: (() -> ())?
    var deleteKidsHandler: (() -> ())?

    @IBOutlet weak var viewMain: AllCornorsBorderedView!{
        didSet {
            viewMain.borderColor = UIColor.gray
            viewMain.isRounded = true
            viewMain.background = UIColor.white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let roundRadius:CGFloat = 5
        viewMain.roundedRadius = roundRadius
        DispatchQueue.main.async {
            self.viewMain.addshadow(top: true, left: true, bottom: true, right: true, shadowRadius: 2, shadowColor: UIColor.darkGray, shadowOpecity: 0.4, roundedRadius: 5)
        }
    }
    
    @IBAction func btnUpdateKidAction(sender: UIButton) {
        self.updateKidsHandler?()
    }
    
    @IBAction func btnDeleteKidAction(sender: UIButton) {
        self.deleteKidsHandler?()
    }
}

class ManageKidsViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableManageKids: UITableView!
    @IBOutlet weak var btnBack: UIButton!

    var kidsModel = ModelKidsList(dict: [:])

    @IBOutlet weak var btnAddKids: UIButton!{
        didSet {
            btnAddKids.layer.cornerRadius = btnAddKids.frame.size.height/2
            btnAddKids.clipsToBounds = true
            btnAddKids.backgroundColor = appColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callAPI_ForGetAllKids()
        if currentTabIndex == 0 {
            self.btnBack.isHidden = false
        } else {
            self.btnBack.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if currentTabIndex == 0 {
            self.btnBack.isHidden = false
        } else {
            self.tabBarController?.tabBar.isHidden = false
            self.btnBack.isHidden = true
        }
    }
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addKidsAction(sender: UIButton) {
        self.view.endEditing(true)
        let storyboard = UIStoryboard.init(name: manageKidsStoryBoard, bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: addKidsViewController) as? AddKidsViewController {
            vc.addKids = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnSaveAction(sender: UIButton) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnShareAction(sender: UIButton) {
        self.view.endEditing(true)
        goToNextVC(storyBoardID: manageKidsStoryBoard, vc_id: shareAllKidsViewController, currentVC: self)
    }
}

//MARK: - Tableview delegate methods
extension ManageKidsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kidsModel.arrKidsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "ManageKidsTableViewCell"
        let kid = kidsModel.arrKidsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ManageKidsTableViewCell
        cell?.lblName.text = kid.name
        cell?.lblAgeGender.text = "\(kid.age) Year, \(kid.gender)"
        cell?.lblSharedBy.text = "Shared by Deependra"
        cell?.deleteKidsHandler = ({
            showAlertVC(title: kAlertTitle, message: wip, controller: self)
        })
        cell?.updateKidsHandler = ({
            self.view.endEditing(true)
            let storyboard = UIStoryboard.init(name: manageKidsStoryBoard, bundle: Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier: addKidsViewController) as? AddKidsViewController {
                vc.addKids = false
                vc.kidsDetail = kid
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: manageKidsStoryBoard, bundle: Bundle.main)
         if let vc = storyboard.instantiateViewController(withIdentifier: kidsDetailViewController) as? KidsDetailViewController {
             vc.modelKidsDetail = self.kidsModel.arrKidsList[indexPath.row]
             self.navigationController?.pushViewController(vc, animated: true)
         }
    }
}

//MARK: - Webservice Method extension
fileprivate extension ManageKidsViewController {

    func callAPI_ForGetAllKids() {
        self.indicator.startAnimating()
        self.kidsModel.arrKidsList.removeAll()
        self.tableManageKids.reloadData()
        webServiceManager.requestGet(strURL: WebURL.getAllKids, success: { (response) in
            self.indicator.stopAnimating()
            print(response)
            self.indicator.stopAnimating()
            if let dict =  response as? [String:Any] {
                self.kidsModel = ModelKidsList.init(dict: dict)
                self.tableManageKids.reloadData()
            } else if let dict =  response["errors"] as? [String:Any] {
                showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
            }
        }, failure: { (error) in
            print(error)
            self.indicator.stopAnimating()
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
}
