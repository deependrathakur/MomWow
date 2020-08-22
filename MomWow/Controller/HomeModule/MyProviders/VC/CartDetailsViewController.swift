//
//  CartDetailsViewController.swift
//  MomWow
//
//  Created by vijay on 22/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class CartDetailsViewController: UIViewController {
    @IBOutlet weak var tableManageKids: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableManageKids.delegate = self
        self.tableManageKids.dataSource = self
        tableManageKids.register(UINib(nibName: "CommanListCell", bundle: nil), forCellReuseIdentifier: "CommanListCell")
        tableManageKids.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        self.tableManageKids.reloadData()
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func becomeMemderAction(sender: UIButton) {
        self.view.endEditing(true)
        
    }
}

//MARK: - Tableview delegate methods
extension CartDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
        if indexPath.row == 0 {
            let cellIdentifier = "CommanListCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CommanListCell
            cell?.firstImage.image = #imageLiteral(resourceName: "boy")
            cell?.firstTitle.text = "Kid"
            cell?.firstName.text = "Rahul Singh"
            
            cell?.secondImage.image = #imageLiteral(resourceName: "horseRider")
            cell?.secondTitle.text = "Activity"
            cell?.secondName.text = "horse riding"
            
            cell?.thirdImage.image = #imageLiteral(resourceName: "boyBlue")
            cell?.thirdTitle.text = "Trainer"
            cell?.thirdName.text = "Navinja"
            
            cell?.viewChackButton.isHidden = true
            
            cell?.callbackHandler = ({ index in
                self.goToDetailScreen(section: indexPath.section, tableindex: indexPath.row, buttonIndex: index)
            })
            return cell!
        } else {
            let cellIdentifier = "CartCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CartCell
            cell?.callbackHandler = ({ index in
                self.goToDetailScreen(section: indexPath.section, tableindex: indexPath.row, buttonIndex: index)
            })
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToNextVC(storyBoardID: progressStoryBoard, vc_id: kidsDetailsViewController, currentVC: self)
    }

    func goToDetailScreen(section: Int, tableindex: Int, buttonIndex: Int) {
        if buttonIndex == 0 {
            
            let storyboard = UIStoryboard.init(name: manageKidsStoryBoard, bundle: Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier: kidsDetailViewController) as? KidsDetailViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if buttonIndex == 1 {
            goToNextVC(storyBoardID: providersStoryBoard, vc_id: academyInfoViewController, currentVC: self)
        } else if buttonIndex == 2 {
                
            let storyboard = UIStoryboard.init(name: providersStoryBoard, bundle: Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier: "TrainerDetailVC") as? TrainerDetailVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if buttonIndex == 3 {
            goToNextVC(storyBoardID: providersStoryBoard, vc_id: academyInfoViewController, currentVC: self)
        } else {
            
        }
    }

}
