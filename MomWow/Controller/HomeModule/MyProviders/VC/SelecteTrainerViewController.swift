//
//  SelecteTrainerViewController.swift
//  MomWow
//
//  Created by vijay on 21/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class SelectTrainersTableViewCell: UITableViewCell {

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
    
    func setBorderToSell(setBorder: Bool) {
        if setBorder {
            viewMain.borderWidth = 1
            viewMain.borderColor = #colorLiteral(red: 0.1411764706, green: 0.2549019608, blue: 0.4156862745, alpha: 1)
            viewMain.background = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9411764706, alpha: 1)
            btnCheck.setImage(UIImage(named: "checkBlue"), for: .normal)
        }else{
            viewMain.borderWidth = 0
            btnCheck.setImage(nil, for: .normal)
            viewMain.borderColor = UIColor.gray
            viewMain.background = UIColor.white
        }
    }
}

class SelecteTrainerViewController: UIViewController {
    
    @IBOutlet weak var tableTrainers: UITableView!
    var index = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.callAPI_getTrainers()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextStepAction(sender: UIButton) {
        self.view.endEditing(true)
        let storyboard = UIStoryboard.init(name: manageKidsStoryBoard, bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: shareAllKidsViewController) as? ShareAllKidsViewController {
            vc.isFromSelectKids = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

//MARK: - Tableview delegate methods
extension SelecteTrainerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "SelectTrainersTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SelectTrainersTableViewCell
        if indexPath.row == index {
            cell?.setBorderToSell(setBorder: true)
        } else {
            cell?.setBorderToSell(setBorder: false)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        self.tableTrainers.reloadData()
    }
}

//MARK: - Tableview delegate methods
extension SelecteTrainerViewController {
    func callAPI_getTrainers() {

        webServiceManager.requestGet(strURL: WebURL.schedules + "\(7)get_trainers", success: { (response) in
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

