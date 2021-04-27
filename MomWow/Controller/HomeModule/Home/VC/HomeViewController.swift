//
//  HomeViewController.swift
//  MomWow
//
//  Created by Harshit on 17/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgBack: UIImageView!
}

class HomeViewController: UIViewController {

    let arrHome:[[String:Any]] = [["name":"Kids", "imageBack":"backgroundOrange", "image":"3KidsIcon"],
                                  ["name":"Piggy Bank", "imageBack":"backgroundPurple", "image":"pigIcon"],
                                  ["name":"Profile", "imageBack":"backGroundPink", "image":"couple"],
                                  ["name":"Kids Progress", "imageBack":"backgroundGreen", "image":"rising"],
                                  ["name":"Scheduler", "imageBack":"backgroundPurpleLight", "image":"calendarColor"],
                                  ["name":"Alerts Setup", "imageBack":"backGroundPinkLight", "image":"notification"],
                                  ["name":"Providers", "imageBack":"backgroundYellow", "image":"boyBlue"],
                                  ["name":"Trainers", "imageBack":"backGroundGreenLight", "image":"boy"]]
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!

    @IBOutlet weak var btnAddCart: UIButton!{
        didSet {
            btnAddCart.layer.cornerRadius = btnAddCart.frame.size.height/2
            btnAddCart.clipsToBounds = true
            btnAddCart.backgroundColor = appColor
        }
    }
    @IBAction func notificationAction(sender: UIButton) {
        goToNextVC(storyBoardID: notificationStoryBoard, vc_id: notificationListVC, currentVC: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "Home")
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrHome.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        let obj = self.arrHome[indexPath.row]
        let image = obj["image"] as? String ?? ""
        let imageBack = obj["imageBack"] as? String ?? ""
        cell.lblName.text = obj["name"] as? String ?? ""
        cell.imgIcon.image = UIImage(named: image)
        cell.imgBack.image = UIImage(named: imageBack)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            goToNextVC(storyBoardID: manageKidsStoryBoard, vc_id: manageKidsViewController, currentVC: self)
        } else if indexPath.item == 1 {
           // goToNextVC(storyBoardID: manageKidsStoryBoard, vc_id: manageKidsViewController, currentVC: self)
        } else if indexPath.item == 2 {
            goToNextVC(storyBoardID: myProfileStoryBoard, vc_id: myProfileViewController, currentVC: self)
        } else if indexPath.item == 3 {
            goToNextVC(storyBoardID: progressStoryBoard, vc_id: kidsProgressViewController, currentVC: self)
        } else if indexPath.item == 4 {
           // goToNextVC(storyBoardID: settingsStoryBoard, vc_id: sed, currentVC: self)
        } else if indexPath.item == 5 {
            goToNextVC(storyBoardID: settingsStoryBoard, vc_id: alertsSetupViewController, currentVC: self)
        } else if indexPath.item == 6 {
            goToNextVC(storyBoardID: providersStoryBoard, vc_id: myProvidersViewController, currentVC: self)
        } else if indexPath.item == 7 {
            goToNextVC(storyBoardID: providersStoryBoard, vc_id: trainersListViewController, currentVC: self)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 45) / 2
        let height = width*0.8
        
        return CGSize(width: width, height: height)
    }
}
