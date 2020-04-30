//
//  SceneDelegate.swift
//  MomWow
//
//  Created by Harshit on 18/03/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navController: UINavigationController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {

            self.window = UIWindow(windowScene: windowScene)
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let initialViewController =
                storyboard.instantiateViewController(withIdentifier: "mainNavigation") as? UINavigationController
                self.window!.rootViewController = initialViewController
                self.window!.makeKeyAndVisible()
            }
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func gotoTabBar(withAnitmation: Bool) {
        // *** Create Main Navigation *** //
        let sb: UIStoryboard = UIStoryboard(name: "TabBar", bundle: Bundle.main)
        navController = sb.instantiateViewController(withIdentifier: "TabBarNav") as? UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
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

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

