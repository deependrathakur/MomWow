//
//  TabBarController.swift
//  MualabCustomer
//
//  Created by Mac on 16/01/18.
//  Copyright © 2018 Mindiii. All rights reserved.
//

import UIKit

var selectedTabIndex:Int = 0
var currentTabIndex:Int = 0

class TabBarController: UITabBarController {
    
    let SEPARATOR_WIDTH = 1.0
    let blueColor = UIColor(red: 119.0 / 255.0, green: 175.0 / 255.0, blue: 58.0 / 255.0, alpha: 1).cgColor
    var selectedTabbarIndex:Int = 0
    
    let kDefaultImg1 = UIImage.init(named: "inactive_calender_ico")
    let kDefaultImg2 = UIImage.init(named: "inactive_dashboard_ico")
    let kDefaultImg3 = UIImage.init(named: "inactive_add_ico")
    let kDefaultImg4 = UIImage.init(named: "inactive_notification_ico")
    let kDefaultImg5 = UIImage.init(named: "inactive_profile_ico")


    let kSelectedImg1 = UIImage.init(named: "active_calender_ico")
    let kSelectedImg2 = UIImage.init(named: "active_dashboard_ico")
    let kSelectedImg3 = UIImage.init(named: "active_add_ico")
    let kSelectedImg4 = UIImage.init(named: "active_notifiction_ico")
    let kSelectedImg5 = UIImage.init(named: "active_profile_ico")

    let kTitleForTab1 = ""
    let kTitleForTab2 = ""
    let kTitleForTab3 = ""
    let kTitleForTab4 = ""
    let kTitleForTab5 = ""
    
    let kNameStoryBoard1 = "Home"
    let kNameStoryBoard2 = "ManageKids"
    let kNameStoryBoard3 = "MyProviders"
    let kNameStoryBoard4 = "Progress"
    let kNameStoryBoard5 = "Settings"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false

       //  addTopBorderOnTabBar()
        for vc in self.viewControllers! {
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }

        self.selectedIndex = selectedTabIndex
        
        // addSeparatorsOnTabBar()
        addUnderlinInTabBarItem()
        // self.addTabBarItems()
        //self.setTitleAndIconOFTabBar()
        // UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0, -2)
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}

//MARK: UITabBarControllerDelegate method
extension TabBarController : UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        currentTabIndex = selectedIndex ?? 0
    }
}

//MARK: Customize UITabBarController method
extension TabBarController{
    
    func addTabBarItems(){
       
  
//        let storyBoard1 : UIStoryboard = UIStoryboard.init(name: kNameStoryBoard1, bundle: nil)
//        var searchBoardVC = storyBoard1.instantiateViewController(withIdentifier: "SearchBoardVC") as! SearchBoardVC
//        let nav1 = UINavigationController(rootViewController: searchBoardVC)
//        
//        let storyBoard2 : UIStoryboard = UIStoryboard.init(name: kNameStoryBoard2, bundle: nil)
//        var feedVc = storyBoard1.instantiateViewController(withIdentifier: "FeedVc") as! FeedVc
//        let nav2 = UINavigationController(rootViewController: feedVc)
//        
        
        /*
         // Create Tab one
         let tabOne = TabOneViewController()
         let tabBarItem1 = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
         
         tabOne.tabBarItem = tabBarItem1
         
         
         // Create Tab two
         let tabTwo = TabTwoViewController()
         let tabBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
         
         tabTwo.tabBarItem = tabBarItem1
         
         self.viewControllers = [tabOne, tabTwo]
         
         */
    }

    func setTitleAndIconOFTabBar() {
        
        let tabBar: UITabBar? = self.tabBar
        let tabBarItem1 = tabBar?.items?[0]
        let tabBarItem2 = tabBar?.items?[1]
        let tabBarItem3 = tabBar?.items?[2]
        let tabBarItem4 = tabBar?.items?[3]
        let tabBarItem5 = tabBar?.items?[4]
       
        
        tabBarItem1?.title = kTitleForTab1
        tabBarItem1?.selectedImage = kSelectedImg1?.withRenderingMode(.alwaysOriginal)
        tabBarItem1?.image = kDefaultImg1?.withRenderingMode(.alwaysOriginal)
        
        tabBarItem2?.title = kTitleForTab2
        tabBarItem2?.selectedImage = kSelectedImg2?.withRenderingMode(.alwaysOriginal)
        tabBarItem2?.image = kDefaultImg2?.withRenderingMode(.alwaysOriginal)
        
        tabBarItem3?.title = kTitleForTab3
        tabBarItem3?.selectedImage = kSelectedImg3?.withRenderingMode(.alwaysOriginal)
        tabBarItem3?.image = kDefaultImg3?.withRenderingMode(.alwaysOriginal)
        
        tabBarItem4?.title = kTitleForTab4
        tabBarItem4?.selectedImage = kSelectedImg4?.withRenderingMode(.alwaysOriginal)
        tabBarItem4?.image = kDefaultImg4?.withRenderingMode(.alwaysOriginal)
        
        tabBarItem5?.title = kTitleForTab5
        tabBarItem5?.selectedImage = kSelectedImg5?.withRenderingMode(.alwaysOriginal)
        tabBarItem5?.image = kDefaultImg5?.withRenderingMode(.alwaysOriginal)
    }

    func addTopBorderOnTabBar(){
//
//        let topBorder = CALayer()
//        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 1.0)
//        // use for the border.
//        topBorder.backgroundColor = UIColor.clear.cgColor //UIColor.lightGray.cgColor
//        //addSublayer(topBorder)
    }
    
    func addSeparatorsOnTabBar(){
        
        let itemWidth = floor(self.tabBar.frame.size.width / CGFloat(self.tabBar.items!.count))
        
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height))
        
        for i in 0..<(tabBar.items?.count)! - 1
        {
            let separator = UIView(frame: CGRect(x: itemWidth * CGFloat(i + 1) - CGFloat(SEPARATOR_WIDTH / 2), y: 10, width: CGFloat(SEPARATOR_WIDTH), height: self.tabBar.frame.size.height-20))
            separator.backgroundColor = UIColor(red: 98.0 / 255.0, green: 98.0 / 255.0, blue: 98.0 / 255.0, alpha: 1)
            bgView.addSubview(separator)
            
        }
        
        UIGraphicsBeginImageContext(bgView.bounds.size)
        bgView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let tabBarBackground = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UITabBar.appearance().backgroundImage = tabBarBackground
        
    }
    
    func addUnderlinInTabBarItem() {
        let tabBar: UITabBar? = self.tabBar
        let divide = 7.0
        
        var height = 60
        if #available(iOS 11.0, *), (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! > CGFloat(0){
            height = 90
        }
        
        let view = UIView(frame: CGRect(x: (tabBar?.frame.origin.x)!, y: (tabBar?.frame.origin.y)!, width: self.view.frame.size.width/CGFloat(divide), height: CGFloat(height)))
        
        let border = UIImageView(frame: CGRect(x: view.frame.origin.x + 3, y: 5, width: self.view.frame.size.width / CGFloat(divide), height: 5))
        border.backgroundColor = appColor
        
        view.addSubview(border)
        UIGraphicsBeginImageContext(view.bounds.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let tabBarBackground = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.tabBar.tintColor = appColor
        
        //bottom line
        tabBar?.selectionIndicatorImage = tabBarBackground
    }
}

