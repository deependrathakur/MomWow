//
//  Extensions.swift
//  MomWow
//
//  Created by vijay on 18/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import Foundation
import UIKit

//MARK: Button extension
extension UIButton {
    func buttonCorner(cornerRadius: CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func addBottomLineWithColor(color: UIColor, lineHeight: Int, textColor: UIColor) {
        let bottomView = UIView(frame: CGRect(x: 0, y: Int(self.layer.frame.height), width: Int(self.layer.frame.width), height: lineHeight))
        bottomView.backgroundColor = color
        self.setTitleColor(textColor, for: .normal)
        self.addSubview(bottomView)
    }
}

//MARK: Image extension
extension UIImage {
    func imageIsNull()-> Bool
    {
       let size = CGSize(width: 0, height: 0)
       if (self.size.width == size.width)
        { return true }  else {  return false }
    }
}
//MARK: Image extension
extension UIImageView {
    func imageCorner(cornerRadius: CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}

//MARK: View extension
extension UIView {
    
    func addGradientLayerWith(color: UIColor){
        let layer = CAGradientLayer()
        layer.colors = [color.cgColor,UIColor.white.cgColor]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 1, y: 0)
        layer.frame = self.bounds
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func addGradientLayerWith(colors: [UIColor], startPoint: CGPoint?, endPoint: CGPoint?){
        let layer = CAGradientLayer()
        var layerColors = [CGColor]()
        for color in colors {
            layerColors.append(color.cgColor)
        }
        layer.colors = layerColors
        layer.locations = [0, 1]
        if startPoint != nil {
            layer.startPoint = startPoint!
        }
        if endPoint != nil {
            layer.endPoint = endPoint!
        }
        layer.frame = self.bounds
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func viewBound(){
        self.layer.cornerRadius = self.layer.frame.width/2
        self.layer.masksToBounds = true
    }
    
    func addshadow(top: Bool, left: Bool, bottom: Bool,  right: Bool, shadowRadius: CGFloat = 2.0, shadowColor: UIColor = .gray, shadowOpecity: Float = 1.0,roundedRadius: CGFloat = 0)  {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpecity
        self.layer.shadowColor = shadowColor.cgColor
        
        var path = UIBezierPath()
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        
        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        
        if roundedRadius > 0 {
            path = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: viewWidth, height: viewHeight), cornerRadius: roundedRadius)
        } else {
            // selecting top most point
            path.move(to: CGPoint(x: x, y: y))
            // Move to the Bottom Left Corner, this will cover left edges
            
            path.addLine(to: CGPoint(x: x, y: viewHeight))
            // Move to the Bottom Right Corner, this will cover bottom edge
            
            path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
            // Move to the Top Right Corner, this will cover right edge
            
            path.addLine(to: CGPoint(x: viewWidth, y: y))
            // Move back to the initial point, this will cover the top edge
        }
        
        path.close()
        self.layer.shadowPath = path.cgPath
    }
}

// MARK: - Date
extension Date {
    
    func stringValue(format: String, use12HourFormat: Bool = true) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        dateFormatter.dateFormat = format
        if use12HourFormat {
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        }
        return dateFormatter.string(from: self)
    }
}

//MARK: TextField extension
extension UITextField {
    
    func changeTextColor(textColor: UIColor) {
        self.textColor = textColor
    }
    
    func textFieldCorner(cornerRadius: CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    //MARK: - Shake Views
    func shakeTextField() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = CGPoint(x:self.center.x - 7,y:self.center.y)
        animation.toValue = CGPoint(x:self.center.x + 7, y:self.center.y)
        self.layer.add(animation,forKey: "position")
    }
    
    func isValidateEmail() -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: self.text ?? "")
    }
    
    func isEmptyText() -> Bool {
        self.text = self.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return (self.text?.count == 0) ? true : false
    }
}
extension String {
    func isValidateEmail() -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: self )
    }
}

extension UIViewController {
    @objc func setTitle(title: String, gestureRecognizer: UITapGestureRecognizer?) {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.text = title
        lbl.textColor = UIColor.white
        lbl.font = UIFont(name: "HelveticaNeue", size: 16)
        lbl.sizeToFit()
        
        if let recognizer = gestureRecognizer {
            lbl.isUserInteractionEnabled = true
            lbl.addGestureRecognizer(recognizer)
            lbl.numberOfLines = 0
        }else {
            lbl.isUserInteractionEnabled = false
        }
        navigationItem.titleView = lbl
        // update back button title for all view controllers calling setTitle method
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func setTitle(title: String) {
        setTitle(title: title, gestureRecognizer: nil)
    }
}

extension UIColor {
    static func myColor() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                // the color can be from your own color config struct as well.
                return trait.userInterfaceStyle == .dark ? blackColor : whiteColor
            }
        }
        else { return UIColor.orange }
    }
}
