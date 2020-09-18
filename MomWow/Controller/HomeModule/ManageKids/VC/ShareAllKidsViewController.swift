//
//  ShareAllKidsViewController.swift
//  MomWow
//
//  Created by vijay on 14/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class Cell_ForShareKidsProfile: UICollectionViewCell {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var imgChacked: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
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

    override func layoutSubviews() {
        super.layoutSubviews()

    }
}

class ShareAllKidsViewController: UIViewController {

    var isFromSelectKids:Bool = false
    var index = -1
    @IBOutlet weak var collectionNearBy: UICollectionView!
    
    @IBOutlet weak var btnProceed: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromSelectKids {
            btnCancel.layer.borderColor = UIColor.orange.cgColor
            btnCancel.setTitleColor(UIColor.orange, for: .normal)
            btnProceed.setTitle("Add to Cart", for: .normal)
            btnCancel.setTitle("Pay at Centre", for: .normal)
            self.lblHeader.text = "Select Kids"
        }
    }

    @IBAction func backAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ProceedAction(sender: UIButton) {
        self.view.endEditing(true)
        if index == -1 {
            showAlertVC(title: "Alert", message: "Please select any kid", controller: self)
            return
        }
        goToNextVC(storyBoardID: providersStoryBoard, vc_id: cartDetailsViewController, currentVC: self)
    }
}

//MARK:- Collection view Delegate Methods
extension ShareAllKidsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "Cell_ForShareKidsProfile"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as? Cell_ForShareKidsProfile
        cell?.imgChacked.isHidden = true
        cell?.imgUser.image = #imageLiteral(resourceName: "boy")

        if indexPath.item == index {
            cell?.imgChacked.isHidden = false
        }
        
        return cell!
    }
    
 /*   func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellWidth = CGFloat((self.collectionNearBy.frame.size.width-20) / 3.0)
            let cellHeight = cellWidth*1.3
            return CGSize(width: cellWidth, height: cellHeight)
    } */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.index == indexPath.item {
            self.index = -1
        } else {
            self.index = indexPath.item
        }
        self.collectionNearBy.reloadData()
    }
}
