//
//  MyProvidersViewController.swift
//  MomWow
//
//  Created by Harshit on 17/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class MyProvidersTableViewCell: UITableViewCell {

    @IBOutlet weak var viewMain: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewMain.layer.cornerRadius = 10
        viewMain.clipsToBounds = true
        viewMain.layer.borderColor = UIColor.lightGray.cgColor
        viewMain.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

class MyProvidersViewController: UIViewController {

    @IBOutlet weak var tableMyProviders: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignOutAction(sender: UIButton) {
        setRootToMainStoryboard()
    }

}

//MARK: - Tableview delegate methods
extension MyProvidersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "MyProvidersTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MyProvidersTableViewCell
        
        return cell!
    }
}
