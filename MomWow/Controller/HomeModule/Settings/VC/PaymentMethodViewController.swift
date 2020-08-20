//
//  PaymentMethodViewController.swift
//  MomWow
//
//  Created by vijay on 22/05/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {
    
    var index:Int = 0

    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var imgPaymentIcon: UIImageView!
    @IBOutlet weak var viewMain: AllCornorsBorderedView!{
        didSet {
            viewMain.borderColor = UIColor.gray
            viewMain.isRounded = true
            viewMain.background = UIColor.white
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
               
        let roundRadius:CGFloat = 5
        viewMain.roundedRadius = roundRadius
        DispatchQueue.main.async {
            self.viewMain.addshadow(top: true, left: true, bottom: true, right: true, shadowRadius: 2, shadowColor: UIColor.darkGray, shadowOpecity: 0.4, roundedRadius: 5)
            
            if self.index == 0{
                self.lblAccount.text = "myself@me.com"
                self.imgPaymentIcon.image = UIImage(named: "paypal")
            }else if self.index == 1{
                self.lblAccount.text = "xxxx-xxxx-xxxx-3453"
                self.imgPaymentIcon.image = UIImage(named: "visa")
            }else{
                self.lblAccount.text = "xxxx-xxxx-xxxx-5678"
                self.imgPaymentIcon.image = UIImage(named: "mastercard")
            }
        }
    }
}

class PaymentMethodViewController: UIViewController {
    
    @IBOutlet weak var tablePaymentMethod: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Tableview delegate methods
extension PaymentMethodViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "PaymentMethodTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PaymentMethodTableViewCell
        
        cell?.index = indexPath.row
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
