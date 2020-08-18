//
//  WebserviceConstant.swift
//  Mualab
//
//  Created by MINDIII on 10/25/17.
//  Copyright © 2017 MINDIII. All rights reserved.

import Foundation
import UIKit

//let objWebserviceManager : WebServiceManager = WebServiceManager.sharedObject()
let k_success = "success"


//MARK : - Webservices
//struct WebURL {
//
////    static var BaseUrl = "https://wow-my-kids.herokuapp.com/api/"
//    static var BaseUrl = "https://wow-my-kids-dev.herokuapp.com/"
//    static let SignUp =  "https://wow-my-kids-dev.herokuapp.com/api/users?"
//    static let Login =  "https://wow-my-kids-dev.herokuapp.com/api/users/login?"
//    static let forgot = "password/forgot"
//
//
//    static let updateProfile = "\(BaseUrl)api/users/update_profile?"
//    static let getAllKids = "kids"
//    static let addKids = "api/kids/mobile_kids_create"
//
// }

struct WebURL {

    static var BaseUrl = "https://wow-my-kids-test.herokuapp.com/"
    static let SignUp =  "\(BaseUrl)api/users?"
    static let Login =  "\(BaseUrl)api/users/login?"
    static let forgot = "\(BaseUrl)api/password/forgot"
    static let updateProfile = "\(BaseUrl)api/users/update_profile?"
    static let getAllKids = "\(BaseUrl)api/parents/\(UserDefaults.standard.value(forKey: UserDefaults.Keys.id) ?? 0 )/get_kids"
    static let addKids = "\(BaseUrl)api/kids/mobile_kids_create"
    static let updateKids = "\(BaseUrl)api/kids/"
    static let getAllTrainers = "\(BaseUrl)api/trainers"
    static let organizations = "\(BaseUrl)api/organizations"
}


