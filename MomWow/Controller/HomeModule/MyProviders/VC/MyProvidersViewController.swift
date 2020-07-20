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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        self.view.endEditing(true)
        self.self.navigationController?.popViewController(animated: true)
    }

}

//MARK: - Tableview delegate methods
extension MyProvidersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "MyProvidersTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MyProvidersTableViewCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        goToNextVC(storyBoardID: providersStoryBoard, vc_id: academyInfoViewController, currentVC: self)
    }
}
