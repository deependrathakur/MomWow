//
//  TrainerDetailVC.swift
//  MomWow
//
//  Created by rails on 22/08/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class TrainerDetailVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var viewProgress1: viewProgress!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.viewProgress1.addNewView(presentageView: 20)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Tableview delegate methods
extension TrainerDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "TrainersListTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TrainersListTableViewCell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToNextVC(storyBoardID: providersStoryBoard, vc_id: selecteTrainerViewController, currentVC: self)
    }
}
