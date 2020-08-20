//
//  AppDelegate.swift
//  MomWow
//
//  Created by Harshit on 18/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//
//Deependra.MomWow //Bundle Identifier
import UIKit
import GoogleSignIn

let appDelegate = AppDelegate.sharedObject()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
  
    var window: UIWindow?
    var navController: UINavigationController?
    
    //MARK: - Shared object
    private static var sharedManager: AppDelegate = {
        let manager = UIApplication.shared.delegate as! AppDelegate
        return manager
    }()
    
    // MARK: - Accessors
    class func sharedObject() -> AppDelegate {
        return sharedManager
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance().clientID = "828338150298-mnj3tdqg6pqi772dmkffgm02f2b0u1p9.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
     
        let token = UserDefaults.standard.string(forKey: UserDefaults.Keys.authToken)
        if token != nil && token?.count ?? 0 > 0{
            self.gotoTabBar(withAnitmation: true)
        }else{
            self.setRootToMainStoryboard(withAnitmation: false)
        }
        
        // Override point for customization after application launch.
        //828338150298-mnj3tdqg6pqi772dmkffgm02f2b0u1p9.apps.googleusercontent.com
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func gotoTabBar(withAnitmation: Bool, isTypeLeft:Bool = false) {
        // *** Create Main Navigation *** //
        let sb: UIStoryboard = UIStoryboard(name: "TabBar", bundle: Bundle.main)
        navController = sb.instantiateViewController(withIdentifier: "TabBarNav") as? UINavigationController
        
        if withAnitmation {
            let transition = CATransition()
            transition.duration = 1.0
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType(rawValue: "cube")
            if isTypeLeft == true{
                transition.subtype = .fromLeft
            }else{
                transition.subtype = .fromRight
            }
            transition.delegate = self as? CAAnimationDelegate
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.layer.add(transition, forKey: nil)
            } else {
                appDelegate.window?.layer.add(transition, forKey: nil)
            }
        }
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = navController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            appDelegate.window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
    }
    
    func setRootToMainStoryboard(withAnitmation: Bool) {
        // *** Create Main Navigation *** //
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        navController = sb.instantiateViewController(withIdentifier: "mainNavigation") as? UINavigationController
        
        if withAnitmation {
            let transition = CATransition()
            transition.duration = 1.0
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType(rawValue: "cube")
            
            transition.subtype = .fromRight
            transition.delegate = self as? CAAnimationDelegate
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.layer.add(transition, forKey: nil)
            } else {
                appDelegate.window?.layer.add(transition, forKey: nil)
            }
        }
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = navController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            appDelegate.window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
    }
    
    func gotoMyProfileRoot(withAnitmation: Bool) {
        // *** Create Main Navigation *** //
        let sb: UIStoryboard = UIStoryboard(name: "MyProfile", bundle: Bundle.main)
        navController = sb.instantiateViewController(withIdentifier: "nav_MyProfile") as? UINavigationController

        if withAnitmation {
            let transition = CATransition()
            transition.duration = 1.0
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType(rawValue: "cube")
            transition.subtype = CATransitionSubtype.fromRight
            transition.delegate = self as? CAAnimationDelegate
            
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.layer.add(transition, forKey: nil)
            } else {
                appDelegate.window?.layer.add(transition, forKey: nil)
            }
        }
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = navController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            appDelegate.window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
    }
}

//MARK: Google sign method
extension AppDelegate {
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
      // ...
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
}
