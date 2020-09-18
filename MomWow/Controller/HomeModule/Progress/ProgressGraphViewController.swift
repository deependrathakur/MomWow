//
//  ProgressGraphViewController.swift
//  MomWow
//
//  Created by vijay on 27/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit
import Charts

class Cell_ForKidsList: UICollectionViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgInfo: UIImageView!
    @IBOutlet weak var selectedImage: UIImageView!

    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
}

class Cell_ForTechniqueList: UICollectionViewCell {

    @IBOutlet weak var imgInfo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var techniqueProgress: viewProgress!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class Cell_ForActivityList: UICollectionViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgInfo: UIImageView!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class ProgressGraphViewController: UIViewController {
    
    @IBOutlet var chartView: LineChartView!
    @IBOutlet weak var collectionKidsList: UICollectionView!
    @IBOutlet weak var collectionActivityList: UICollectionView!
    @IBOutlet weak var collectionTechniqueyList: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    var kidsModel = ModelKidsList(dict: [:])
    
    @IBOutlet weak var btnBack: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureChartData()
//        if currentTabIndex == 0 {
//            self.btnBack.isHidden = false
//        } else {
//            self.tabBarController?.tabBar.isHidden = false
//            self.btnBack.isHidden = true
//        }
        self.indicator.isHidden = true
        self.callAPI_ForGetAllKids()
    }
    
    var selectedActivity = -1
    var selectedKids = -1

    func configureChartData(){
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        let l = chartView.legend
        l.form = .line
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.textColor = .black
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 11)
        xAxis.labelTextColor = .black
        xAxis.drawAxisLineEnabled = false
        
        let leftAxis = chartView.rightAxis
        leftAxis.labelTextColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        leftAxis.axisMaximum = 200
        leftAxis.axisMinimum = 0
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        
        let rightAxis = chartView.rightAxis
        rightAxis.labelTextColor = .red
        rightAxis.axisMaximum = 900
        rightAxis.axisMinimum = -200
        rightAxis.granularityEnabled = false
        
        chartView.animate(xAxisDuration: 2.5)
        
        //update data to chart
        self.setDataCount(Int(18 + 1), range: UInt32(100))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
            let mult = range / 2
            let val = Double(arc4random_uniform(mult) + 50)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
            let mult = range / 2
            let val = Double(arc4random_uniform(mult) + 50)
            return ChartDataEntry(x: Double(i), y: val)
        }

        let set1 = LineChartDataSet(entries: yVals1, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(#colorLiteral(red: 0.9431690574, green: 0.5541301966, blue: 0.01150577608, alpha: 1))
        set1.setCircleColor(.black)
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 65/255
        set1.fillColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        set1.highlightColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let set2 = LineChartDataSet(entries: yVals1, label: "DataSet 2")
        set1.axisDependency = .left
        set1.setColor(#colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1))
        set1.setCircleColor(.black)
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 65/255
        set1.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        set1.highlightColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let data = LineChartData(dataSets: [set1, set2])
        data.setValueTextColor(.black)
        data.setValueFont(.systemFont(ofSize: 9))
        
        chartView.data = data

        for set in chartView.data!.dataSets as! [LineChartDataSet] {
            set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
        }
        chartView.setNeedsDisplay()
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProgressGraphViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionActivityList {
            return 4
        } else if collectionView == self.collectionKidsList {
            return self.kidsModel.arrKidsList.count
        } else if collectionView == self.collectionTechniqueyList {
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionActivityList {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell_ForActivityList", for: indexPath) as! Cell_ForActivityList
            cell.selectedImage.isHidden = true
            if selectedActivity == indexPath.item {
                cell.selectedImage.isHidden = false
            }
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
            
        } else if collectionView == self.collectionKidsList {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell_ForKidsList", for: indexPath) as! Cell_ForKidsList
            cell.selectedImage.isHidden = true
            if selectedKids == indexPath.item {
                cell.selectedImage.isHidden = false
            }
            return cell
            
        } else if collectionView == self.collectionTechniqueyList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell_ForTechniqueList", for: indexPath) as! Cell_ForTechniqueList
            
            if indexPath.item == 0 {
                cell.imgInfo.image = #imageLiteral(resourceName: "frog")
                cell.techniqueProgress.addNewView(presentageView: 29, progressColor: #colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1))

            } else if indexPath.item == 1 {
                cell.imgInfo.image = #imageLiteral(resourceName: "yellowKidIcon")
                cell.techniqueProgress.addNewView(presentageView: 89, progressColor: #colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1))

            } else if indexPath.item == 2 {
               cell.imgInfo.image = #imageLiteral(resourceName: "blueFloat")
                cell.techniqueProgress.addNewView(presentageView: 39, progressColor: #colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1))

            } else {
                cell.imgInfo.image = #imageLiteral(resourceName: "noun_bubbles")
                cell.techniqueProgress.addNewView(presentageView: 15, progressColor: #colorLiteral(red: 0.1403674483, green: 0.2673855634, blue: 0.4140264988, alpha: 1))

            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionActivityList {
            self.selectedActivity = indexPath.item
        } else if collectionView == self.collectionKidsList {
            self.selectedKids = indexPath.item
        } else if collectionView == self.collectionTechniqueyList {

        }
        self.collectionKidsList.reloadData()
        self.collectionActivityList.reloadData()
    }
}
//MARK: Call API
fileprivate extension ProgressGraphViewController{
    func callAPI_ForGetAllKids() {
        self.indicator.startAnimating()
        self.kidsModel.arrKidsList.removeAll()
        webServiceManager.requestGet(strURL: WebURL.getAllKids, success: { (response) in
            self.indicator.stopAnimating()
            print(response)
            self.indicator.stopAnimating()
            if let dict =  response as? [String:Any] {
                self.kidsModel = ModelKidsList.init(dict: dict)
                self.collectionKidsList.reloadData()
            } else if let dict =  response["errors"] as? [String:Any] {
                showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
            }
        }, failure: { (error) in
            print(error)
            self.indicator.stopAnimating()
            self.collectionKidsList.reloadData()
            showAlertVC(title: kAlertTitle, message: kErrorMessage, controller: self)
        })
    }
}
