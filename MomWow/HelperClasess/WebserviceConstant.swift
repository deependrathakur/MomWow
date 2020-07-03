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
struct WebURL {

//    static var BaseUrl = "https://wow-my-kids.herokuapp.com/api/"
    static var BaseUrl = "https://wow-my-kids-dev.herokuapp.com/"
    static let SignUp =  "https://wow-my-kids-dev.herokuapp.com/api/users?"
    static let Login =  "https://wow-my-kids-dev.herokuapp.com/api/users/login?"
    static let forgot = "password/forgot"
    

    static let updateProfile = "https://wow-my-kids-dev.herokuapp.com/api/users/update_profile?"
    static let getAllKids = "kids"
    static let addKids = "kids"
    
 }




