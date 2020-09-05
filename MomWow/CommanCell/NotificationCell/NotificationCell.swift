//
//  NotificationCell.swift
//  MomWow
//
//  Created by rails on 03/09/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMessage: UILabel!

    var callbackHandler: ((_ selectIndex : Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func buttonClickAction(sender: UIButton) {
        self.callbackHandler?(sender.tag)
    }
    
}
