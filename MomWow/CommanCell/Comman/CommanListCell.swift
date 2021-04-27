//
//  CommanListCell.swift
//  MomWow
//
//  Created by rails on 17/08/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class CommanListCell: UITableViewCell {
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var forthImage: UIImageView!
    @IBOutlet weak var checkedImage: UIImageView!

    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var thirdTitle: UILabel!
    @IBOutlet weak var forthTitle: UILabel!

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var secondName: UILabel!
    @IBOutlet weak var thirdName: UILabel!
    @IBOutlet weak var forthName: UILabel!
    
    @IBOutlet weak var forthView: UIView!
    
    @IBOutlet weak var viewChackButton: UIView!

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
