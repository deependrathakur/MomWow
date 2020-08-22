//
//  Header.swift
//  MomWow
//
//  Created by rails on 17/08/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class Header: UIView {
    @IBOutlet weak var imageTop: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var callbackHandler: ((_ selectIndex : Int) -> Void)?
    
    @IBAction func buttonClickAction(sender: UIButton) {
        self.callbackHandler?(sender.tag)
    }
}
