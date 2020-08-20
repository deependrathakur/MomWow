//
//  activityIndicator.swift
//  demoLogin
//
//  Created by Mac on 27/10/2017 .
//  Copyright © 2017 Mindiii. All rights reserved.
//

import UIKit

class activityIndicator:UIViewController {
    
    fileprivate var activityIndicatorImage : UIImageView!
    fileprivate var backView: UIView!
    fileprivate var window = UIApplication.shared.keyWindow

    func startActivityIndicator() -> Void {
        window = UIWindow(frame: UIScreen.main.bounds)
        activityIndicatorImage = UIImageView(image: UIImage(named: "lodar_img"))
        activityIndicatorImage.tintColor = UIColor.white
        activityIndicatorImage.frame = CGRect.init(x: 0, y: 0, width:40, height:40)
        backView = UIView(frame: window!.frame)
        //backView!.backgroundColor = UIColor.black
        backView!.alpha = 0.5
        backView!.center = window!.center
        //
        let gradient = CAGradientLayer()
        
        gradient.frame = backView!.bounds
        gradient.colors = [UIColor.black.cgColor,UIColor.white.cgColor]
        gradient.locations=[0.0,1.0]
        gradient.startPoint=CGPoint(x: 0, y: 10)
        gradient.endPoint=CGPoint(x: 0, y: backView!.bounds.height/2.5)
        backView!.layer.insertSublayer(gradient,at: 0)
        
        //
        activityIndicatorImage!.center = window!.center
        window!.addSubview(backView!)
        window!.addSubview(activityIndicatorImage!)
        window!.makeKeyAndVisible()
        rotatImage(layer:activityIndicatorImage!.layer)
    }
    
    func rotatImage(layer:CALayer) -> Void {
        var rotation: CABasicAnimation!
        rotation = CABasicAnimation(keyPath:"transform.rotation")
        rotation.fromValue = NSNumber(value: 0)
        rotation.toValue = NSNumber(value: (Float(2*Double.pi)))
        rotation.duration = 1.0
        // Speed
        rotation.repeatCount = Float(Double.infinity)
        // Repeat forever. Can be a finite number.
        layer.removeAllAnimations()
        layer.add(rotation, forKey: "Spin")
    }
    
    
    func stopActivity() -> Void {
        UIApplication.shared.statusBarStyle = .lightContent
        if activityIndicatorImage != nil{
            activityIndicatorImage.removeFromSuperview();
        }
        if backView != nil{
            backView.removeFromSuperview();
        }
        if window != nil{
            window?.resignKey()
        }
        
        activityIndicatorImage=nil;
        backView=nil
        window = nil
    }
    
}
