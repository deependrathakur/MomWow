//
//  TrainersListViewController.swift
//  MomWow
//
//  Created by vijay on 23/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit
import HCSStarRatingView

class TrainersListTableViewCell: UITableViewCell {
    
    var index:Int = 0
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var rattingView: HCSStarRatingView!
    @IBOutlet weak var lblNmae: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!

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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var modelTrainer = ModelTrainerList(dict: [:])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callWebserviceForTrainerList()
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - Tableview delegate methods
extension TrainersListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelTrainer.trainers.count
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

//MARK: - Tableview delegate methods
extension TrainersListViewController {
    
    func callWebserviceForTrainerList() {
        self.indicator.startAnimating()

        WebserviceForTrainer().requestGetTrainer(strURL: WebURL.getAllTrainers, success: { (response) in
            self.indicator.stopAnimating()
                   print(response)
                   self.indicator.stopAnimating()
                   if let dict =  response as? [String:Any] {
                       self.modelTrainer = ModelTrainerList.init(dict: dict)
                       self.tableTrainers.reloadData()
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

//MARK: WebserviceManager class
import Alamofire
class WebserviceForTrainer:WebServiceManager  {
    
    public func requestGetTrainer(strURL:String, success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        let headers:HTTPHeaders = ["Authorization" : UserDefaults.standard.string(forKey: UserDefaults.Keys.authToken) ?? ""]
        
        AF.request(strURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { responseObject in
            
            self.StopIndicator()
            switch responseObject.result {
            case .success(let value):
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    // Session Expire
                    let dict = dictionary as! Dictionary<String, Any>
                    if dict["status"] as? String ?? "" != "success"{
                        if let msg = dict["message"] as? String{
                        }
                    }
                    print("\n response = \(dictionary)")
                    success(dictionary as! Dictionary<String, Any>)
                }catch{
                }
            case .failure(let error):
                failure(error)
                self.StopIndicator()
            }
        }
    }
}
