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
        tableTrainers.register(UINib(nibName: "CommanListCell", bundle: nil), forCellReuseIdentifier: "CommanListCell")

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
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.modelTrainer.trainers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelTrainer.trainers[section].kids.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let modelObject = self.modelTrainer.trainers[section]
        let header = Bundle.main.loadNibNamed("Header", owner: nil, options: nil)?[0] as? Header
        header!.backgroundColor = UIColor.white
        header?.lblTitle.text = modelObject.first_name + " " + modelObject.last_name
        header?.callbackHandler = ({ index in
            let storyboard = UIStoryboard.init(name: providersStoryBoard, bundle: Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier: "TrainerDetailVC") as? TrainerDetailVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = Bundle.main.loadNibNamed("Footer", owner: nil, options: nil)?[0] as? Footer
        footer!.backgroundColor = UIColor.white
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let obj = self.modelTrainer.trainers[indexPath.section].kids[indexPath.row]
        let cellIdentifier = "CommanListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CommanListCell
        cell?.firstImage.image = #imageLiteral(resourceName: "boy")
        cell?.firstTitle.text = "Kid"
        cell?.firstName.text = obj.name
        
        cell?.secondImage.image = #imageLiteral(resourceName: "horseRider")
        cell?.secondTitle.text = "Activity"
        cell?.secondName.text = "Swimming"//obj.domains[indexPath.row].name
        
        cell?.thirdImage.image = #imageLiteral(resourceName: "boyBlue")
        cell?.thirdTitle.text = "Level"
        cell?.thirdName.text = "Frog"
        
        cell?.forthImage.image = #imageLiteral(resourceName: "boyBlue")
        cell?.forthTitle.text = "Centre Name"
        cell?.forthName.text = "Dolphin Swimming"
        
        cell?.viewChackButton.isHidden = true
        cell?.forthView.isHidden = false
        cell?.callbackHandler = ({ index in
            self.goToDetailScreen(section: indexPath.section, tableindex: indexPath.row, buttonIndex: index)
        })
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func goToDetailScreen(section: Int, tableindex: Int, buttonIndex: Int) {
        if buttonIndex == 0 {
            
            let storyboard = UIStoryboard.init(name: manageKidsStoryBoard, bundle: Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier: kidsDetailViewController) as? KidsDetailViewController {
                vc.modelKidsDetail = self.modelTrainer.trainers[section].kids[tableindex]
               // vc.modelProvider = self.modelProviderList[section]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if buttonIndex == 1 {
           // goToNextVC(storyBoardID: providersStoryBoard, vc_id: academyInfoViewController, currentVC: self)
        } else if buttonIndex == 2 {
                
          //  let storyboard = UIStoryboard.init(name: providersStoryBoard, bundle: Bundle.main)
           // if let vc = storyboard.instantiateViewController(withIdentifier: "TrainerDetailVC") as? TrainerDetailVC {
           //     self.navigationController?.pushViewController(vc, animated: true)
           // }
        } else if buttonIndex == 3 {
         //   goToNextVC(storyBoardID: providersStoryBoard, vc_id: academyInfoViewController, currentVC: self)
        } else {
            
        }
    }
        
}

//MARK: - Tableview delegate methods
extension TrainersListViewController {
    
    func callWebserviceForTrainerList() {
        self.indicator.startAnimating()

        WebserviceForTrainer().requestGetTrainer(strURL: WebURL.getTrainers, success: { (response) in
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
