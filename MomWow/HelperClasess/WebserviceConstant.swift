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

struct WebURL {

    static var BaseUrl = "https://wow-my-kids-test.herokuapp.com/"
    static let SignUp =  "\(BaseUrl)api/users?"
    static let Login =  "\(BaseUrl)api/users/login?"
    static let forgot = "\(BaseUrl)api/password/forgot"
    static let updateProfile = "\(BaseUrl)api/parents/update_parent"
    static let getAllKids = "\(BaseUrl)api/parents/\(UserDefaults.standard.value(forKey: UserDefaults.Keys.id) ?? 0 )/get_kids"
    static let addKids = "\(BaseUrl)api/kids/mobile_kids_create"
    static let updateKids = "\(BaseUrl)api/kids/"
    static let getAllTrainers = "\(BaseUrl)api/trainers"
    static let organizations = "\(BaseUrl)api/organizations"

    static let levels = "\(BaseUrl)api/levels"
    static let domains = "\(BaseUrl)api/domains"
    static let techniques = "\(BaseUrl)api/techniques"
    static let schedules = "\(BaseUrl)api/schedules/"
    static let getTrainers = "\(BaseUrl)api/trainers/mobile_index"
    static let getNotification = "\(BaseUrl)api/trainers/mobile_index"

}
