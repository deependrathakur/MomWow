//
//  ModelKidsList.swift
//  MomWow
//
//  Created by rails on 20/07/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ModelKidsList: NSObject {
    var message = "";
    var status = ""
    var status_code = ""
    var arrKidsList = [ModelKidsDetail]()
    
     init(dict: [String : Any]) {
        message = dictToStringKeyParam(dict: dict, key: "message")
        status = dictToStringKeyParam(dict: dict, key: "status")
        status_code = dictToStringKeyParam(dict: dict, key: "status_code")
        if let data = dict["data"] as? [[String:Any]] {
            for obj in data {
                arrKidsList.append(ModelKidsDetail.init(dict: obj))
            }
        }
    }
}

class ModelKidsDetail: NSObject {
    var age = "";
    var created_at = "";
    var email = "";
    var gender = "";
    var id = "";
    var name = "";
    var organization_id = "";
    var parent_id = "";
    var training_type = "";
    var updated_at = "";
    
    init(dict: [String : Any]) {
        age = dictToStringKeyParam(dict: dict, key: "age")
        created_at = dictToStringKeyParam(dict: dict, key: "created_at")
        email = dictToStringKeyParam(dict: dict, key: "email")
        gender = dictToStringKeyParam(dict: dict, key: "gender")
        id = dictToStringKeyParam(dict: dict, key: "id")
        name = dictToStringKeyParam(dict: dict, key: "name")
        organization_id = dictToStringKeyParam(dict: dict, key: "organization_id")
        parent_id = dictToStringKeyParam(dict: dict, key: "parent_id")
        training_type = dictToStringKeyParam(dict: dict, key: "training_type")
        updated_at = dictToStringKeyParam(dict: dict, key: "updated_at")
    }
}

func dictToStringKeyParam(dict: [String:Any], key: String) -> String {
    if let value = dict[key] as? String {
        return value
    } else if let value = dict[key] as? Int {
        return String(value)
    } else if let value = dict[key] as? Double {
        return String(value)
    } else if let value = dict[key] as? Float {
        return String(value)
    } else {
        return ""
    }
}
