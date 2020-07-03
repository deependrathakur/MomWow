//
//  ManageKidsViewController.swift
//  MomWow
//
//  Created by Harshit on 17/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ManageKidsTableViewCell: UITableViewCell {

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

class ManageKidsViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableManageKids: UITableView!
    
    @IBOutlet weak var btnAddKids: UIButton!{
        didSet {
            btnAddKids.layer.cornerRadius = btnAddKids.frame.size.height/2
            btnAddKids.clipsToBounds = true
            btnAddKids.backgroundColor = appColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.indicator.stopAnimating()
//        self.callAPI_ForGetAllKids()
//        postAction()
    }
    
    @IBAction func addKidsAction(sender: UIButton) {
        self.view.endEditing(true)
        
        goToNextVC(storyBoardID: manageKidsStoryBoard, vc_id: addKidsViewController, currentVC: self)
    }
    
    @IBAction func btnSaveAction(sender: UIButton) {
        self.view.endEditing(true)

    }
    
    @IBAction func btnShareAction(sender: UIButton) {
        self.view.endEditing(true)

        goToNextVC(storyBoardID: manageKidsStoryBoard, vc_id: shareAllKidsViewController, currentVC: self)
    }
}

//MARK: - Tableview delegate methods
extension ManageKidsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "ManageKidsTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ManageKidsTableViewCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        goToNextVC(storyBoardID: manageKidsStoryBoard, vc_id: kidsDetailViewController, currentVC: self)
    }
}

//MARK: - Webservice Method extension
fileprivate extension ManageKidsViewController {
    
    func postAction() {
        let Url = String(format: "https://wow-my-kids.herokuapp.com/api/graders")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = [String:Any]()
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func callAPI_ForGetAllKids() {
        
        let dict2 = [String:Any]()
        
        self.indicator.startAnimating()
        webServiceManager.requestGet(strURL: WebURL.getAllKids, params: dict2, success: { (response) in
            print(response)
            self.indicator.stopAnimating()
            if let dict =  response["user"] as? [String:Any] {
                AppDelegate().gotoTabBar(withAnitmation: true)
                // showAlertVC(title: kAlertTitle, message: dict["messages"] as? String ?? "", controller: self)
            } else if let dict =  response["errors"] as? [String:Any] {
                if let email = dict["email"] as? String {
                    showAlertVC(title: kAlertTitle, message: "Email has already registered", controller: self)
                } else {
                    showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
                }
            }
        }, failure: { (error) in
            print(error)
            self.indicator.stopAnimating()
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
}
