//
//  ModelUser.swift
//  MomWow
//
//  Created by Harshit on 22/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ModelUser: NSObject {
    var email: String?
    var first_name: String?
    var gender: String?
    var id: String?
    var last_name: String?
    var middle_name: String?
    var phone_number: String?
    var token: String?

    init(dictionary: [String: AnyObject]) {
        self.first_name = dictionary["first_name"] as? String
        self.email = dictionary["email"] as? String
        self.gender = dictionary["gender"] as? String
        self.id = dictionary["id"] as? String
        self.last_name = dictionary["last_name"] as? String
        self.middle_name = dictionary["middle_name"] as? String
        self.phone_number = dictionary["phone_number"] as? String
        self.token = dictionary["token"] as? String
    }
}
