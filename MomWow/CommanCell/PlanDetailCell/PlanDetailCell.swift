//
//  PlanDetailCell.swift
//  MomWow
//
//  Created by rails on 22/08/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class PlanDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblActivity: UILabel!
    @IBOutlet weak var lblAvailability: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblMemberPrice: UILabel!
    @IBOutlet weak var lblNormalPrice: UILabel!
    
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
