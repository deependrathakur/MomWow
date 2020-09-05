//
//  NotificationListVC.swift
//  MomWow
//
//  Created by rails on 03/09/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class NotificationListVC: UIViewController {
    
    
    @IBOutlet weak var tableNotification: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var modelNotification = ModelTrainerList(dict: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callWebserviceForNotificationList()
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - Tableview delegate methods
extension NotificationListVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.modelNotification.trainers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelNotification.trainers[section].kids.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let modelObject = self.modelNotification.trainers[section]
        let header = Bundle.main.loadNibNamed("Header", owner: nil, options: nil)?[1] as? LabelHeader
        header!.backgroundColor = UIColor.white
        header?.button.setTitle(modelObject.first_name + " " + modelObject.last_name, for: .normal)
        header?.callbackHandler = ({ index in
        })
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let obj = self.modelNotification.trainers[indexPath.section].kids[indexPath.row]
        let cellIdentifier = "NotificationCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? NotificationCell
        cell?.lblDay.text = "Today"
        cell?.lblMessage.text = "Hello this is new notification for kids please notify to to your all kids Hello this is new notification for kids please notify to to your all kids Hello this is new notification for kids please notify to to your all kids  "

        cell?.callbackHandler = ({ index in
        })
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
}

//MARK: - Tableview delegate methods
extension NotificationListVC {
    
    func callWebserviceForNotificationList() {
        self.indicator.startAnimating()
        
        WebserviceForNotification().requestGetNotification(strURL: WebURL.getNotification, success: { (response) in
            self.indicator.stopAnimating()
            print(response)
            self.indicator.stopAnimating()
            if let dict =  response as? [String:Any] {
                self.modelNotification = ModelTrainerList.init(dict: dict)
                self.tableNotification.reloadData()
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
class WebserviceForNotification: WebServiceManager  {
    
    public func requestGetNotification(strURL:String, success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
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
