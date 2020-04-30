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
}

class HomeViewController: UIViewController {

    let arrHome:[[String:Any]] = [["name":"Kids", "image":"Tab_kids"], ["name":"Piggy Bank", "image":"Tab_piggy"], ["name":"Profile", "image":"Tab_profile"], ["name":"Kids Progress", "image":"Tab_kidsProgress"], ["name":"Scheduler", "image":"Tab_schedular"], ["name":"Alerts Setup", "image":"Tab_alerts"], ["name":"Providers", "image":"Tab_providers"], ["name":"Trainers", "image":"Tab_trainers"]]
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "Home")
    }
    
    @IBAction func SignOutAction(sender: UIButton) {
        setRootToMainStoryboard()
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
        //cell.lblName.text = obj["name"] as? String ?? ""
        cell.imgIcon.image = UIImage(named: image)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 45) / 2
        let height = width*0.8
        
        return CGSize(width: width, height: height)
    }
}
