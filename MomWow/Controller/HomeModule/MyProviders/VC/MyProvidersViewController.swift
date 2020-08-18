//
//  MyProvidersViewController.swift
//  MomWow
//
//  Created by Harshit on 17/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class MyProvidersTableViewCell: UITableViewCell {

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
}

class MyProvidersViewController: UIViewController {

    @IBOutlet weak var tableMyProviders: UITableView!
    
    @IBOutlet weak var btnBack: UIButton!
    var modelProviderList = [ModelProviderList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMyProviders.register(UINib(nibName: "CommanListCell", bundle: nil), forCellReuseIdentifier: "CommanListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentTabIndex == 0 {
            self.btnBack.isHidden = false
        } else {
            self.btnBack.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
        
        self.callAPI_ForOrganizations()
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
        self.view.endEditing(true)
        self.self.navigationController?.popViewController(animated: true)
    }

}

//MARK: - Tableview delegate methods
extension MyProvidersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.modelProviderList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelProviderList[section].domains[0].schedules.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let modelObject = self.modelProviderList[section]
        let header = Bundle.main.loadNibNamed("Header", owner: nil, options: nil)?[0] as? Header
        header!.backgroundColor = UIColor.white
        header?.lblTitle.text = modelObject.name
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = Bundle.main.loadNibNamed("Footer", owner: nil, options: nil)?[0] as? Footer
        footer!.backgroundColor = UIColor.white
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "CommanListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CommanListCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        goToNextVC(storyBoardID: providersStoryBoard, vc_id: academyInfoViewController, currentVC: self)
    }
    
    func callAPI_ForOrganizations() {
        self.modelProviderList.removeAll()
        webServiceManager.requestGet(strURL: WebURL.organizations, success: { (response) in
               print(response)
            
               if let dict =  response as? [String:Any] {
                if let organizationsList = dict["organizations"] as? [[String:Any]] {
                    for obj in organizationsList {
                        let newObj = ModelProviderList.init(dict: obj)
                        self.modelProviderList.append(newObj)

                    }
                    self.tableMyProviders.reloadData()
                }
               } else if let dict =  response["errors"] as? [String:Any] {
                self.tableMyProviders.reloadData()
                showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
               }
           }, failure: { (error) in
               print(error)
                self.tableMyProviders.reloadData()
               showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
           })
    }
}
