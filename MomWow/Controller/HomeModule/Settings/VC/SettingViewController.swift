//
//  SettingViewController.swift
//  MomWow
//
//  Created by Harshit on 17/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var txtName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstName = UserDefaults.standard.string(forKey: UserDefaults.Keys.first_name) ?? "Username"
        let lastName = UserDefaults.standard.string(forKey: UserDefaults.Keys.last_name) ?? ""
        
        self.txtName.text = firstName+" "+lastName

    }
    
    @IBAction func EditProfileAction(sender: UIButton) {
        self.view.endEditing(true)
        //AppDelegate().gotoMyProfileRoot(withAnitmation: true)
        goToNextVC(storyBoardID: myProfileStoryBoard, vc_id: myProfileViewController, currentVC: self)

    }
    
    @IBAction func SignOutAction(sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.authToken)
        AppDelegate().setRootToMainStoryboard(withAnitmation: true)
    }
    
    @IBAction func changeNumberAction(sender: UIButton) {
        goToNextVC(storyBoardID: settingsStoryBoard, vc_id: changeNumberViewController, currentVC: self)
    }
    
    @IBAction func changePasswordAction(sender: UIButton) {
        goToNextVC(storyBoardID: settingsStoryBoard, vc_id: changePasswordViewController, currentVC: self)
    }
    
    @IBAction func deactivateAccountAction(sender: UIButton) {
        goToNextVC(storyBoardID: settingsStoryBoard, vc_id: deactivateAccountViewController, currentVC: self)
    }
    
    @IBAction func memberShipAction(sender: UIButton) {
        goToNextVC(storyBoardID: settingsStoryBoard, vc_id: memberShipViewController, currentVC: self)
    }
    
    @IBAction func paymentMethodAction(sender: UIButton) {
        goToNextVC(storyBoardID: settingsStoryBoard, vc_id: paymentMethodViewController, currentVC: self)
    }
    
    @IBAction func notificationAction(sender: UIButton) {
        goToNextVC(storyBoardID: settingsStoryBoard, vc_id: alertsSetupViewController, currentVC: self)
    }
}

