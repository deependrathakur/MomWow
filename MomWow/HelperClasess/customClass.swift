//
//  customBorder.swift
//  MualabBusiness
//
//  Created by Mac on 10/02/2018 .
//  Copyright © 2018 Mindiii. All rights reserved.
//

import UIKit

class viewBorder: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable override var clipsToBounds: Bool {
        get {
            return layer.masksToBounds
        }set {
            layer.masksToBounds = true
        }
    }
}

class viewProgress: UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            self.addNewView(presentageView: Int(layer.cornerRadius))
            return CGFloat(self.frame.height/2)
        }set {
            self.addNewView(presentageView: Int(newValue))
            layer.cornerRadius = CGFloat(self.frame.height/2)
        }
    }
    
    func addNewView(presentageView: Int, backgroundColor: UIColor? = UIColor.lightGray, progressColor: UIColor? = UIColor.orange) {
        
        let width = Int(self.frame.width)
        let height = Int(self.frame.height)
        
        let myNewView = UIView(frame: CGRect(x: 0, y: 0, width: ((width/100) * presentageView), height: height))
        myNewView.backgroundColor = progressColor
        
        self.layer.cornerRadius = CGFloat(height/2)
        myNewView.layer.cornerRadius = CGFloat(height/2)
        
        self.backgroundColor =  backgroundColor
        self.addSubview(myNewView)
    }
}

class buttonBorder: UIButton {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable override var clipsToBounds: Bool {
        get {
            return layer.masksToBounds
        }set {
            layer.masksToBounds = true
        }
    }
}

class labelBorder: UILabel {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable override var clipsToBounds: Bool {
        get {
            return layer.masksToBounds
        }set {
            layer.masksToBounds = true
        }
    }
}

class tableBorder: UITableView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable override var clipsToBounds: Bool {
        get {
            return layer.masksToBounds
        }set {
            layer.masksToBounds = true
        }
    }
}

class textFieldBorder: UITextField {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable override var clipsToBounds: Bool {
        get {
            return layer.masksToBounds
        }set {
            layer.masksToBounds = true
        }
    }
}

class textViewBorder: UITextView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable override var clipsToBounds: Bool {
        get {
            return layer.masksToBounds
        }set {
            layer.masksToBounds = true
        }
    }
}

class imageBorder: UIImageView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable override var clipsToBounds: Bool {
        get {
            return layer.masksToBounds
        }set {
            layer.masksToBounds = true
        }
    }
}

class AllCornorsBorderedView: UIView {
    
    var isRounded = false { didSet { setNeedsDisplay() } }
    var roundedRadius: CGFloat = 0.0 { didSet { setNeedsDisplay() } }
    var background = UIColor.clear { didSet { setNeedsDisplay() } }
    @IBInspectable var borderColor: UIColor = UIColor.gray { didSet { setNeedsDisplay() } }
    @IBInspectable var borderWidth: CGFloat = 0.5 { didSet { setNeedsDisplay() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = isRounded ? UIBezierPath(roundedRect: rect, cornerRadius: roundedRadius) : UIBezierPath(rect: rect)
        background.setFill()
        borderColor.setStroke()
        path.lineWidth = borderWidth
        path.addClip()
        path.fill()
        path.stroke()
    }
}

class GradientLayeredButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor.orange.cgColor, UIColor.systemYellow.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1.5, y: 0.5)
        l.cornerRadius = self.frame.size.height/2
        layer.insertSublayer(l, at: 0)
        return l
    }()
}

class GradientLayeredView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor.orange.cgColor, UIColor.systemYellow.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1.5, y: 0.5)
        layer.insertSublayer(l, at: 0)
        return l
    }()
}

func crtToDateString(crd: String) -> String {
    let newDate = crd
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let date = dateFormatter.date(from: newDate)
    
    let array = crd.components(separatedBy: " ")
    if array.count > 0 && date == nil {
        return array[0]
    } else {
        let formattedTime: String = dateFormatter.string(from: date ?? Date())
        return formattedTime
    }
}
