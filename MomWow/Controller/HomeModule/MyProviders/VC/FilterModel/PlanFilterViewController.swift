//
//  PlanFilterViewController.swift
//  MomWow
//
//  Created by rails on 22/09/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class PlanFilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionActivity: UICollectionView!
    
    @IBOutlet weak var buttonTypeNormal: UIButton!
    @IBOutlet weak var buttonTypeGroup: UIButton!
    
    @IBOutlet weak var collectionDay: UICollectionView!
    
    @IBOutlet weak var lblFromDate: UILabel!
    @IBOutlet weak var lblToDate: UILabel!

    @IBOutlet weak var btnFromAM: UIButton!
    @IBOutlet weak var btnFromPM: UIButton!
    
    @IBOutlet weak var btnToAM: UIButton!
    @IBOutlet weak var btnToPM: UIButton!
    
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var viewPicker: UIView!
    
    var arrayDay = ["ALL", "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    var arraySelectedDay = [String]()
    var arrActivity = ["Swimming", "Karate"]
    var fromDate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionActivity.delegate = self
        self.collectionActivity.dataSource = self
        self.collectionDay.delegate = self
        self.collectionDay.dataSource = self
        self.collectionActivity.reloadData()
        self.collectionDay.reloadData()
        self.viewPicker.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectTypeAction(sender: UIButton) {
        self.view.endEditing(true)
        if sender.tag == 0 {
            self.buttonTypeNormal.setImage(#imageLiteral(resourceName: "circleUncheckWhite"), for: .normal)
            self.buttonTypeGroup.setImage(#imageLiteral(resourceName: "inactiveCircleCheck"), for: .normal)
        } else {
            self.buttonTypeGroup.setImage(#imageLiteral(resourceName: "circleUncheckWhite"), for: .normal)
            self.buttonTypeNormal.setImage(#imageLiteral(resourceName: "inactiveCircleCheck"), for: .normal)
        }
    }
    
    @IBAction func dismissAction(sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func selectTimeAction(sender: UIButton) {
        self.view.endEditing(true)
        self.viewPicker.isHidden = false
        fromDate = true
        if sender.tag == 1 {
            fromDate = false
        }
    }
    
    @IBAction func fromToAmPm(sender: UIButton) {
        if sender.tag == 0 {
            self.btnFromAM.backgroundColor = #colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1)
            self.btnFromPM.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnFromAM.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.btnFromPM.setTitleColor(#colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1), for: .normal)
        } else if sender.tag == 1 {
            self.btnFromAM.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnFromPM.backgroundColor = #colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1)
            self.btnFromAM.setTitleColor(#colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1), for: .normal)
            self.btnFromPM.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        } else if sender.tag == 2 {
            self.btnToAM.backgroundColor = #colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1)
            self.btnToPM.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnToAM.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.btnToPM.setTitleColor(#colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1), for: .normal)
        } else if sender.tag == 3 {
            self.btnToAM.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnToPM.backgroundColor = #colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1)
            self.btnToAM.setTitleColor(#colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1), for: .normal)
            self.btnToPM.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
    }
    
    @IBAction func applyCancelAction(sender: UIButton) {
        self.view.endEditing(true)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func selectDateAction(sender: UIButton) {
        self.view.endEditing(true)
        if sender.tag == 1 {
            self.selectDate(isSelect: false)
            self.viewPicker.isHidden = true
        } else if sender.tag == 2 {
            self.selectDate(isSelect: true)
            self.viewPicker.isHidden = true
        }
    }
    
    func selectDate(isSelect: Bool) {
        if fromDate && isSelect {
            self.lblFromDate.text = crtToDateString(crd: String(describing: self.picker.date))
        } else if !fromDate && isSelect {
            self.lblToDate.text = crtToDateString(crd: String(describing: self.picker.date))
        }
        self.viewPicker.isHidden = true
    }
}

extension PlanFilterViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionDay {
            return self.arrayDay.count
        } else if collectionView == collectionActivity {
            return self.arrActivity.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var value = ""
        if collectionView == collectionDay {
            value = self.arrayDay[indexPath.item]
        } else if collectionView == collectionActivity {
            value = self.arrActivity[indexPath.item]
        }
        if collectionView == self.collectionActivity {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell_ForActivityList", for: indexPath) as! Cell_ForActivityList
            cell.selectedImage.isHidden = true
            cell.lblTitle.text = value
            if indexPath.item == 0 {
                cell.imgInfo.image = #imageLiteral(resourceName: "tennis")
            } else if indexPath.item == 1 {
                cell.imgInfo.image = #imageLiteral(resourceName: "swiming")
            } else if indexPath.item == 2 {
               cell.imgInfo.image = #imageLiteral(resourceName: "karate")
            } else {
                cell.imgInfo.image = #imageLiteral(resourceName: "football")
            }
            
            return cell
            
        } else if collectionView == self.collectionDay {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell_ForActivityList", for: indexPath) as! Cell_ForActivityList
            cell.lblTitle.text = value
            return cell
            
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionDay {
            
        }
    }
}
