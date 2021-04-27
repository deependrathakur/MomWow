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
        tableKidsProgress.register(UINib(nibName: "CommanListCell", bundle: nil), forCellReuseIdentifier: "CommanListCell")

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      //  let modelObject = self.modelProviderList[section]
        let header = Bundle.main.loadNibNamed("Header", owner: nil, options: nil)?[0] as? Header
        header!.backgroundColor = UIColor.white
        header?.lblTitle.text = "Hello developer it is under progress"//modelObject.name
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
        cell?.forthView.isHidden = true
                cell?.callbackHandler = ({ index in
            if index  == 4 {
                if cell?.checkedImage.image == #imageLiteral(resourceName: "rememberInactive") {
                    cell?.checkedImage.image = #imageLiteral(resourceName: "rememberActive")
                } else {
                    cell?.checkedImage.image = #imageLiteral(resourceName: "rememberInactive")
                }
            } else {
                self.goToDetailScreen(section: indexPath.section, tableindex: indexPath.row, buttonIndex: index)
            }
        })
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToNextVC(storyBoardID: progressStoryBoard, vc_id: kidsDetailsViewController, currentVC: self)
    }
    
    func callAPI_ForUpdateProfile1() {

        webServiceManager.requestGet(strURL: WebURL.getAllKids, success: { (response) in
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
    
    
    func goToDetailScreen(section: Int, tableindex: Int, buttonIndex: Int) {
        if buttonIndex == 0 {

        } else if buttonIndex == 1 {
//            goToNextVC(storyBoardID: providersStoryBoard, vc_id: academyInfoViewController, currentVC: self)
        } else if buttonIndex == 2 {

        } else if buttonIndex == 3 {
//            goToNextVC(storyBoardID: providersStoryBoard, vc_id: academyInfoViewController, currentVC: self)
        } else {
            
        }
    }
}
