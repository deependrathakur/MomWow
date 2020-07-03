//
//  TrainersListViewController.swift
//  MomWow
//
//  Created by vijay on 23/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class TrainersListTableViewCell: UITableViewCell {
    
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

class TrainersListViewController: UIViewController {
    
    @IBOutlet weak var tableTrainers: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - Tableview delegate methods
extension TrainersListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "TrainersListTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TrainersListTableViewCell
        
        cell?.index = indexPath.row
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
