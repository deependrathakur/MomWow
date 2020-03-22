//
//  AppDelegate.swift
//  MomWow
//
//  Created by Harshit on 18/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

let appDelegate = AppDelegate.sharedObject()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK: - Shared object
    private static var sharedManager: AppDelegate = {
        let manager = UIApplication.shared.delegate as! AppDelegate
        return manager
    }()
    
    // MARK: - Accessors
    class func sharedObject() -> AppDelegate {
        return sharedManager
    }
    
    var window: UIWindow?
    var navController: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func gotoTabBar(withAnitmation: Bool) {
        // *** Create Main Navigation *** //
        let sb: UIStoryboard = UIStoryboard(name: "TabBar", bundle: Bundle.main)
        navController = sb.instantiateViewController(withIdentifier: "TabBarNav") as? UINavigationController
        
        if withAnitmation {
            let transition = CATransition()
            transition.duration = 1.0
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType(rawValue: "cube")
            transition.subtype = CATransitionSubtype.fromRight
            transition.delegate = self as? CAAnimationDelegate
            appDelegate.window?.layer.add(transition, forKey: nil)
        }
        
        appDelegate.window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

