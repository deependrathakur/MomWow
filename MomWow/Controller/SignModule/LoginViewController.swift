//
//  LoginViewController.swift
//  MomWow
//
//  Created by rails on 20/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit
import Alamofire
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController, GIDSignInDelegate{
    
    var isRememberClicked:Bool = false
    
    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblCopyRight: UILabel!
    @IBOutlet weak var imgRemember: UIImageView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        
        let isRemember = UserDefaults.standard.bool(forKey: UserDefaults.Keys.isRemember)
        if isRemember{
            
            self.txtEmailPhone.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.rememberEmail)
            self.txtPassword.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.rememberPassword)
            
            self.isRememberClicked = true
            self.imgRemember.image = UIImage(named: "rememberActive")
        }else{
            self.txtEmailPhone.text = ""
            self.txtPassword.text = ""
            self.isRememberClicked = false
            self.imgRemember.image = UIImage(named: "rememberInactive")
        }
        
        self.indicator.stopAnimating()
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

//MARK: - Button Method extension
fileprivate extension LoginViewController {
    
    @IBAction func loginAction(sender: UIButton) {
        self.view.endEditing(true)
        self.validation()
    }
    
    @IBAction func signUpAction(sender: UIButton) {
        self.view.endEditing(true)
        goToNextVC(storyBoardID: mainStoryBoard, vc_id: signUpVC, currentVC: self)
    }
    
    @IBAction func forgotAction(sender: UIButton) {
        self.view.endEditing(true)
        goToNextVC(storyBoardID: mainStoryBoard, vc_id: forgotPassword, currentVC: self)
    }
    
    @IBAction func googleAction(sender: UIButton) {
        self.view.endEditing(true)
        GIDSignIn.sharedInstance().signIn()
        //showAlertVC(title: kAlertTitle, message: wip, controller: self)
    }
    
    @IBAction func facebookAction(sender: UIButton) {
        self.view.endEditing(true)
        AppDelegate().gotoTabBar(withAnitmation: true)
       // self.faceBookData()
       // showAlertVC(title: kAlertTitle, message: wip, controller: self)
    }
    
    @IBAction func btnRememberAction(sender: UIButton) {
        self.view.endEditing(true)
        
        if self.imgRemember.image == UIImage(named: "rememberInactive"){
            self.isRememberClicked = true
            self.imgRemember.image = UIImage(named: "rememberActive")
        }else{
            self.isRememberClicked = false
            self.imgRemember.image = UIImage(named: "rememberInactive")
        }
    }
    
    @IBAction func btnShowHidePasswordAction(sender: UIButton) {
        self.view.endEditing(true)
        
        if self.btnShowHidePassword.image(for: .normal) == UIImage(named: "eyeIconClose"){
            self.txtPassword.isSecureTextEntry = false
            self.btnShowHidePassword.setImage(UIImage(named: "eyeOpen"), for: .normal)
        }else{
            self.txtPassword.isSecureTextEntry = true
            self.btnShowHidePassword.setImage(UIImage(named: "eyeIconClose"), for: .normal)
        }
    }
}

//MARK: - Custome Method extension
fileprivate extension LoginViewController {
    func validation() {
        if self.txtEmailPhone.isEmptyText() {
            self.txtEmailPhone.shakeTextField()
        } else if !self.txtEmailPhone.isValidateEmail() {
            showAlertVC(title: kAlertTitle, message: InvalidEmail, controller: self)
        } else if self.txtPassword.isEmptyText() {
            self.txtPassword.shakeTextField()
        } else {
            callAPI_ForLogin()
        }
    }
}

//MARK: - Webservice Method extension
fileprivate extension LoginViewController {
    
    func callAPI_ForLogin1(){
        
        let urlDict = "user[email]=\(self.txtEmailPhone.text!)&user[password]=\(self.txtPassword.text!)&user[phone_number]=\(self.txtEmailPhone.text!)&user[user_type]=admin"
        
        let urlString = WebURL.Login+urlDict
        
        let newURL = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let searchURL = URL(string: newURL ?? "")
        self.indicator.startAnimating()
        
        AF.request(searchURL!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response.result)
            
            switch response.result {
                
            case .success(_):
                self.indicator.stopAnimating()
                if let json = response.value
                {
                    let dict = json as? [String:Any]
                    let data = dict?["data"] as? [String:Any] ?? [:]
                    _ = UserModel.init(dict: data)
                    
                    let message = dict?["status"] as? String ?? ""
                    if message == "ok"{
                        if self.isRememberClicked{
                            UserDefaults.standard.setValue(true, forKey: UserDefaults.Keys.isRemember)
                            UserDefaults.standard.setValue(self.txtEmailPhone.text ?? "", forKey: UserDefaults.Keys.rememberEmail)
                            UserDefaults.standard.setValue(self.txtPassword.text ?? "", forKey: UserDefaults.Keys.rememberPassword)
                        }else{
                            UserDefaults.standard.setValue(false, forKey: UserDefaults.Keys.isRemember)
                            UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.rememberEmail)
                            UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.rememberPassword)
                        }
                        selectedTabIndex = 0
                        AppDelegate().gotoTabBar(withAnitmation: true)
                        print(json)
                    }else{
                        showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
                    }
                }else{
                    showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
                }
                break
            case .failure(let error):
                self.indicator.stopAnimating()
                showAlertVC(title: kAlertTitle, message: error.localizedDescription, controller: self)
                print(error)
                break
            }
        }
    }
    
    func callAPI_ForLogin() {
        
        let dict = ["user[email]":(txtEmailPhone.isValidateEmail() == true) ? (txtEmailPhone.text ?? "") : "",
                    "user[password]":self.txtPassword.text ?? "",
                    "user[phone_number]":(txtEmailPhone.isValidateEmail() == true) ? "" : (txtEmailPhone.text ?? ""),
                    "user[user_type]":"admin", "user[type]":"Parent"]
        self.indicator.startAnimating()
        
        webServiceManager.requestPost(strURL: WebURL.Login, params: dict, success: { (response) in
            print(response)
            self.indicator.stopAnimating()
            if (response["status_code"] as? Int) == 200 {
                
                let data = response["data"] as? [String:Any] ?? [:]
                
                _ = UserModel.init(dict: data)
                UserDefaults.standard.setValue(data[UserDefaults.Keys.authToken], forKey: UserDefaults.Keys.authToken)
                
                if self.isRememberClicked{
                    UserDefaults.standard.setValue(true, forKey: UserDefaults.Keys.isRemember)
                    UserDefaults.standard.setValue(self.txtEmailPhone.text ?? "", forKey: UserDefaults.Keys.rememberEmail)
                    UserDefaults.standard.setValue(self.txtPassword.text ?? "", forKey: UserDefaults.Keys.rememberPassword)
                }else{
                    UserDefaults.standard.setValue(false, forKey: UserDefaults.Keys.isRemember)
                    UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.rememberEmail)
                    UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.rememberPassword)
                }
                selectedTabIndex = 0
                AppDelegate().gotoTabBar(withAnitmation: true)
                
            } else {
                if let message =  response["message"] as? String {
                    showAlertVC(title: kAlertTitle, message: message , controller: self)
                } else if  let message =  response["error"] as? String {
                    showAlertVC(title: kAlertTitle, message: message , controller: self)
                }
            }
        }, failure: { (error) in
            self.indicator.stopAnimating()
            print(error)
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
}

//MARK: - Facebook sign in method
extension LoginViewController {
    
    func faceBookData ()
    {
        let fbLoginManager : LoginManager = LoginManager()
        //        fbLoginManager.loginBehavior = LoginBehavior.systemAccount
        //        fbLoginManager.loginBehavior = LoginBehavior.browser
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) in
            
            if (error == nil){
                //objIndicator.startActivityIndicator()
                let fbloginresult : LoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    //objWebServiceManager.StopIndicator()
                    self.getFBUserData()
                    fbLoginManager.logOut()
                }
                
            }else{
                //objIndicator.stopActivityIndicator()
            }
        }
    }
    func getFBUserData(){
        
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //                    objAppShareData.dictFaceBookData = result as! [String : AnyObject]
                    //                    objAppShareData.strSocialId = objAppShareData.dictFaceBookData["id"] as? String ?? ""
                    //                    objAppShareData.strSocialEmail = objAppShareData.dictFaceBookData["email"] as? String ?? ""
                    //                    self.strEmail = objAppShareData.strSocialEmail
                    //                    self.strName = objAppShareData.dictFaceBookData["name"] as? String ?? ""
                    //                    objAppShareData.strSocialName = objAppShareData.dictFaceBookData["name"] as? String ?? ""
                    //                    objAppShareData.strSocialImage = "https://graph.facebook.com/" + objAppShareData.strSocialId + "/picture?width=543&height=543" //type=normal
                    
                    //FB large image - "/picture?type=large"
                    //FB Custom image - "/picture?width=500&height=500"
                    
                    //                    let imgURL = NSURL(string: objAppShareData.StrFbPic!)
                    //
                    //                    if let theProfileImageUrl = imgURL {
                    //                        do {
                    //                            objAppShareData.imgFbData = try Data(contentsOf: theProfileImageUrl as URL)
                    //                            _ = UIImage(data: objAppShareData.imgFbData!)
                    //
                    //                            //objIndicator.stopActivityIndicator()
                    //                        }catch{
                    //                            //objIndicator.stopActivityIndicator()
                    //                        }
                    //                    }
                    //                    objIndicator.startActivityIndicator()
                    //                    self.call_for_webservice_CheckSocialRegistration()
                    
                }else{
                    //objIndicator.stopActivityIndicator()
                }
            })}}
}


//MARK:- Google sign in method
extension LoginViewController {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else{
            let dimension = round(100 * UIScreen.main.scale)
            if let pic = user.profile.imageURL(withDimension: UInt(dimension)){
                //objAppShareData.strSocialImage = pic.absoluteString
            }
            //            objAppShareData.strSocialId = user.userID
            //            objAppShareData.strSocialName = user.profile.name
            //            objAppShareData.strSocialEmail = user.profile.email
            //            self.strEmail = user.profile.email
            //            self.strName = user.profile.name
            GIDSignIn.sharedInstance().signOut()
            //            objIndicator.startActivityIndicator()
            //            self.call_for_webservice_CheckSocialRegistration()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
    
    //Google sign
    func sign(_ signIn: GIDSignIn!,present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: false, completion: nil)
    }
}
