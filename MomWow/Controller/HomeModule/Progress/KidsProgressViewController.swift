//
//  ProgressViewController.swift
//  MomWow
//
//  Created by Harshit on 17/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class KidsProgressTableViewCell: UITableViewCell {
    
    var index:Int = 0

    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var imgCheck: UIImageView!
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

class KidsProgressViewController: UIViewController {
    
    @IBOutlet weak var tableKidsProgress: UITableView!
    
    @IBOutlet weak var btnBack: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentTabIndex == 0 {
            self.btnBack.isHidden = false
        } else {
            self.tabBarController?.tabBar.isHidden = false
            self.btnBack.isHidden = true
        }
        self.callAPI_ForUpdateProfile1()
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
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Tableview delegate methods
extension KidsProgressViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "KidsProgressTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? KidsProgressTableViewCell
        
        cell?.index = indexPath.row
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        goToNextVC(storyBoardID: progressStoryBoard, vc_id: kidsDetailsViewController, currentVC: self)
    }
    
    func callAPI_ForUpdateProfile1() {

        webServiceManager.requestGet(strURL: "", success: { (response) in
               print(response)
               if let dict =  response as? [String:Any] {

               } else if let dict =  response["errors"] as? [String:Any] {
                   showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
               }
           }, failure: { (error) in
               print(error)
               showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
           })
    }
}
