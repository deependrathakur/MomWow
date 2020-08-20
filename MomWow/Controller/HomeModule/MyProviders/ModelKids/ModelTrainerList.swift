//
//  ModelTrainerList.swift
//  MomWow
//
//  Created by rails on 21/07/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ModelTrainerList: NSObject {
    var trainers = [ModelTrainerDetail]()

    init(dict: [String : Any]) {
        if let data = dict["trainers"] as? [[String:Any]] {
            for obj in data {
                trainers.append(ModelTrainerDetail.init(dict: obj))
            }
        }
    }
}

class ModelTrainerDetail: NSObject {
    var id = ""
    var first_name = ""
    var last_name = ""
    var email = ""
    var phone_number = ""
    var status = ""
    var gender = ""
    var profile_pic = [ModelProfile_pic]()
    var grader_id = ""
    var grader_name = ""
    var kids_names = [String]()
    var days_availibility = ""
    var time_availibility = ""
    
     init(dict: [String : Any]) {
        id = dictToStringKeyParam(dict: dict, key: "id")
        first_name = dictToStringKeyParam(dict: dict, key: "first_name")
        last_name = dictToStringKeyParam(dict: dict, key: "last_name")
        email = dictToStringKeyParam(dict: dict, key: "email")
        phone_number = dictToStringKeyParam(dict: dict, key: "phone_number")
        status = dictToStringKeyParam(dict: dict, key: "status")
        gender = dictToStringKeyParam(dict: dict, key: "gender")
        status = dictToStringKeyParam(dict: dict, key: "status")

        grader_id = dictToStringKeyParam(dict: dict, key: "grader_id")
        grader_name = dictToStringKeyParam(dict: dict, key: "grader_name")
        days_availibility = dictToStringKeyParam(dict: dict, key: "days_availibility")
        time_availibility = dictToStringKeyParam(dict: dict, key: "time_availibility")

        
        if let arrProfile_pic = dict["profile_pic"] as? [[String:Any]] {
            for obj in arrProfile_pic {
                profile_pic.append(ModelProfile_pic.init(dict: obj))
            }
        }
        
        if let arrKids_names = dict["kids_names"] as? [String] {
            for obj in arrKids_names {
                kids_names.append(obj)
            }
        }
    }
}

class ModelProfile_pic: NSObject {
    var id = ""
    var iattachable_id = ""
    var iattachable_type = ""
    var icreated_at = ""
    var iupdated_at = ""
    var attachment = [String:Any]()
    
    init(dict: [String : Any]) {
        id = dictToStringKeyParam(dict: dict, key: "id")
        iattachable_id = dictToStringKeyParam(dict: dict, key: "iattachable_id")
        iattachable_type = dictToStringKeyParam(dict: dict, key: "iattachable_type")
        icreated_at = dictToStringKeyParam(dict: dict, key: "icreated_at")
        iupdated_at = dictToStringKeyParam(dict: dict, key: "iupdated_at")

        if let arrProfile_pic = dict["attachment"] as? [String:Any] {
            attachment = arrProfile_pic
        }
    }
}
