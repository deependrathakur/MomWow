//
//  AcademyInfoViewController.swift
//  MomWow
//
//  Created by vijay on 18/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class Cell_ForAcademyInfo: UICollectionViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewNextButton: viewBorder!
    @IBOutlet weak var viewPreviousButton: viewBorder!
    @IBOutlet weak var btnNextImage: UIButton!
    @IBOutlet weak var btnPreviousImage: UIButton!
    @IBOutlet weak var imgNextImage: UIImageView!
    @IBOutlet weak var imgPreviousImage: UIImageView!
    @IBOutlet weak var imgInfo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
}

class TrainersTableViewCell: UITableViewCell {

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

class AcademyInfoViewController: UIViewController {
    
    @IBOutlet weak var btnNextImage: UIButton!
    @IBOutlet weak var btnPreviousImage: UIButton!
    @IBOutlet weak var viewInfoBottom: UIView!
    @IBOutlet weak var viewAvailabilityBottom: UIView!
    @IBOutlet weak var viewReviewsBottom: UIView!
    @IBOutlet weak var viewPlansBottom: UIView!
    
    @IBOutlet weak var viewInfoMain: UIView!
    @IBOutlet weak var viewAvailabilityMain: UIView!
    @IBOutlet weak var viewReviewsMain: UIView!
    @IBOutlet weak var viewPlansMain: UIView!

    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAvailability: UILabel!
    @IBOutlet weak var lblReviews: UILabel!
    @IBOutlet weak var lblPlans: UILabel!
    
    @IBOutlet weak var tableTrainers: UITableView!
    @IBOutlet weak var collectionAcademyInfo: UICollectionView!
    
    @IBOutlet weak var viewReviewBar: UIView!
    @IBOutlet weak var reviewBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnPreviousLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnNextTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnPreviousHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnNextHeightConstraint: NSLayoutConstraint!
    
    var isFromTrainerReviewList = true
    let cellScale:CGFloat = 0.6
    var closestCellIndex = 0
    
    @IBOutlet weak var viewPlanDetail: AllCornorsBorderedView!{
        didSet {
            viewPlanDetail.borderColor = UIColor.gray
            viewPlanDetail.isRounded = true
            viewPlanDetail.background = UIColor.white
        }
    }
    
    let arrHome:[[String:Any]] = [["name":"Kids", "imageBack":"Tab_alerts", "image":"3KidsIcon"], ["name":"Piggy Bank", "imageBack":"Tab_kids", "image":"pigIcon"], ["name":"Profile", "imageBack":"Tab_kidsProgress", "image":"couple"], ["name":"Kids Progress", "imageBack":"Tab_piggy", "image":"rising"], ["name":"Scheduler", "imageBack":"Tab_profile", "image":"calendarColor"], ["name":"Alerts Setup", "imageBack":"Tab_providers", "image":"notification"], ["name":"Providers", "imageBack":"Tab_schedular", "image":"boyBlue"], ["name":"Trainers", "imageBack":"Tab_trainers", "image":"boy"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.changeColorOfTopbarLabels()
        self.lblInfo.textColor = #colorLiteral(red: 0.1409700513, green: 0.2551564574, blue: 0.4160763919, alpha: 1)
        self.viewInfoBottom.isHidden = false
        self.viewInfoMain.isHidden = false
        
        if self.isFromTrainerReviewList == false{
            self.tableTopConstraint.constant = 60
            self.viewReviewBar.isHidden = true
            self.reviewBarHeightConstraint.constant = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.closestCellIndex == 0{
            self.btnPreviousImage.isHidden = true
        }
        
        self.btnNextImage.setImage(nil, for: .normal)
        self.btnPreviousImage.setImage(nil, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        if self.arrHome.count >= closestCellIndex{
            self.closestCellIndex = self.closestCellIndex+1
        }
       
        self.btnPreviousImage.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        self.btnNextImage.setImage(#imageLiteral(resourceName: "backRight"), for: .normal)
        let cellWidth = self.collectionAcademyInfo.frame.size.width/1.2
        let po = self.collectionAcademyInfo.frame.size.width - cellWidth

        self.btnPreviousLeadingConstraint.constant = po/4
        self.btnNextTrailingConstraint.constant = po/4
        
        self.btnPreviousHeightConstraint.constant = po/2
        self.btnNextHeightConstraint.constant = po/2
        self.collectionAcademyInfo.scrollToNearestVisibleCollectionViewCell(closestCellIndex:self.closestCellIndex, totalCellCount: self.arrHome.count)
        self.collectionAcademyInfo.reloadData()
        self.btnPreviousImage.isHidden = false

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let roundRadius:CGFloat = 10
        viewPlanDetail.roundedRadius = roundRadius
        DispatchQueue.main.async {
            self.viewPlanDetail.addshadow(top: true, left: true, bottom: true, right: true, shadowRadius: 2, shadowColor: UIColor.darkGray, shadowOpecity: 0.4, roundedRadius: roundRadius)
        }
        
    }
    
    func changeColorOfTopbarLabels(){
        
        self.lblInfo.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.viewInfoBottom.isHidden = true
        self.lblAvailability.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.viewAvailabilityBottom.isHidden = true
        self.lblReviews.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.viewReviewsBottom.isHidden = true
        self.lblPlans.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.viewPlansBottom.isHidden = true
        
        self.viewInfoMain.isHidden = true
        self.viewAvailabilityMain.isHidden = true
        self.viewReviewsMain.isHidden = true
        self.viewPlansMain.isHidden = true
    }
    
    func scrollingFroNextAndPreviousButton() -> CGFloat{
        
        self.collectionAcademyInfo.scrollToNearestVisibleCollectionViewCell(closestCellIndex:self.closestCellIndex, totalCellCount: self.arrHome.count)
        self.collectionAcademyInfo.reloadData()
        
        self.btnNextImage.setImage(nil, for: .normal)
        self.btnPreviousImage.setImage(nil, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.btnPreviousImage.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            self.btnNextImage.setImage(#imageLiteral(resourceName: "backRight"), for: .normal)
        }
        
        let cellWidth = self.collectionAcademyInfo.frame.size.width/1.2
        
        let position = self.collectionAcademyInfo.frame.size.width - cellWidth
        
        self.btnPreviousLeadingConstraint.constant = position/4
        self.btnNextTrailingConstraint.constant = position/4
        
        return position
    }
    
    @IBAction func btnPreviousImage(sender: UIButton) {
       
        if closestCellIndex > 0{
            self.closestCellIndex = self.closestCellIndex-1
        }
        
        let position = self.scrollingFroNextAndPreviousButton()
       
        if self.closestCellIndex == 0{
            self.btnNextTrailingConstraint.constant = position/1.35
            self.btnPreviousImage.isHidden = true
        }else{
            self.btnNextImage.isHidden = false
        }
    }
    
    @IBAction func btnNextImageAction(sender: UIButton) {
    
        if self.arrHome.count >= closestCellIndex{
            self.closestCellIndex = self.closestCellIndex+1
        }
        
        let position = self.scrollingFroNextAndPreviousButton()
        
        if self.closestCellIndex == self.arrHome.count - 1{
            self.btnPreviousLeadingConstraint.constant = position/1.35
            self.btnNextImage.isHidden = true
        }else{
            self.btnPreviousImage.isHidden = false
        }
    }
    
    @IBAction func btnInfoAction(sender: UIButton) {
        self.view.endEditing(true)
        
        self.changeColorOfTopbarLabels()
        self.lblInfo.textColor = #colorLiteral(red: 0.1409700513, green: 0.2551564574, blue: 0.4160763919, alpha: 1)
        self.viewInfoBottom.isHidden = false
        self.viewInfoMain.isHidden = false
    }
    
    @IBAction func btnAvailabilityAction(sender: UIButton) {
        self.view.endEditing(true)
        
        self.changeColorOfTopbarLabels()
        self.lblAvailability.textColor = #colorLiteral(red: 0.1409700513, green: 0.2551564574, blue: 0.4160763919, alpha: 1)
        self.viewAvailabilityBottom.isHidden = false
        self.viewAvailabilityMain.isHidden = false
    }
    
    @IBAction func btnReviewsAction(sender: UIButton) {
        self.view.endEditing(true)
        
        self.changeColorOfTopbarLabels()
        self.lblReviews.textColor = #colorLiteral(red: 0.1409700513, green: 0.2551564574, blue: 0.4160763919, alpha: 1)
        self.viewReviewsBottom.isHidden = false
        self.viewReviewsMain.isHidden = false
    }
    
    @IBAction func btnPlansAction(sender: UIButton) {
        self.view.endEditing(true)
        
        self.changeColorOfTopbarLabels()
        self.lblPlans.textColor = #colorLiteral(red: 0.1409700513, green: 0.2551564574, blue: 0.4160763919, alpha: 1)
        self.viewPlansBottom.isHidden = false
        self.viewPlansMain.isHidden = false
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}

extension AcademyInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrHome.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell_ForAcademyInfo", for: indexPath) as! Cell_ForAcademyInfo
        
        let obj = self.arrHome[indexPath.row]
        let imageBack = obj["imageBack"] as? String ?? ""
        cell.imgInfo.image = UIImage(named: imageBack)
        
        cell.viewPreviousButton.isHidden = false
        cell.viewNextButton.isHidden = false
                
        if indexPath.item == 0{
            cell.viewPreviousButton.isHidden = true
        }else if indexPath.item == self.arrHome.count - 1{
            cell.viewNextButton.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = self.collectionAcademyInfo.frame.size.width/1.2
        let cellHeight = self.collectionAcademyInfo.frame.size.height

        return CGSize(width: cellWidth, height: cellHeight)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell(closestCellIndex:Int, totalCellCount:Int) {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
//                closestCellIndex = closestCellIndex+1//self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex >= 0 && totalCellCount > closestCellIndex{
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        print(closestCellIndex)
    }
}

//MARK: - Tableview delegate methods
extension AcademyInfoViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "TrainersTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TrainersTableViewCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        goToNextVC(storyBoardID: providersStoryBoard, vc_id: selecteTrainerViewController, currentVC: self)
    }
}
