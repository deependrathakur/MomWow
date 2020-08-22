//
//  ModelProviderList.swift
//  MomWow
//
//  Created by rails on 17/08/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import UIKit

class ModelProviderList: NSObject {
    var id = ""
    var name = ""
    var phone_number = ""
    var status = ""
    var domains = [ModelDomainList]()
    var kids = [ModelKidsDetail]()
    init(dict: [String : Any]) {
        id = dictToStringKeyParam(dict: dict, key: "id")
        name = dictToStringKeyParam(dict: dict, key: "name")
        phone_number = dictToStringKeyParam(dict: dict, key: "phone_number")
        status = dictToStringKeyParam(dict: dict, key: "status")

        if let data = dict["domains"] as? [[String:Any]] {
            for obj in data {
                domains.append(ModelDomainList.init(dict: obj))
            }
        }
        
        if let data = dict["kids"] as? [[String:Any]] {
            for obj in data {
                kids.append(ModelKidsDetail.init(dict: obj))
            }
        }
    }
}

class ModelDomainList : NSObject {
    var active = ""
    var created_at = ""
    var id = ""
    var name = ""
    var organization_id = ""
    var updated_at = ""
    var schedules = [ModelSchedulesList]()
    
    init(dict: [String : Any]) {
        active = dictToStringKeyParam(dict: dict, key: "active")
        created_at = dictToStringKeyParam(dict: dict, key: "created_at")
        id = dictToStringKeyParam(dict: dict, key: "id")
        name = dictToStringKeyParam(dict: dict, key: "name")
        organization_id = dictToStringKeyParam(dict: dict, key: "organization_id")
        updated_at = dictToStringKeyParam(dict: dict, key: "updated_at")

        if let data = dict["schedules"] as? [[String:Any]] {
            for obj in data {
                schedules.append(ModelSchedulesList.init(dict: obj))
            }
        }
    }
}

class ModelSchedulesList : NSObject {
    var created_at = ""
    var days_availability = [String]()
    var domain_id = ""
    var from_age = ""
    var id = ""
    var kid_ratio = ""
    var middle_name = ""
    var name = ""
    var other_name = ""
    var price_for_members = ""
    var price_for_non_members = ""
    var registration_from = ""
    var registration_to = ""
    var schedule_from = ""
    var schedule_to = ""
    var status = ""
    var teacher_ratio = ""
    var time_from = ""
    var time_to = ""
    var to_age = ""
    var updated_at = ""
    
    init(dict: [String : Any]) {
        created_at = dictToStringKeyParam(dict: dict, key: "created_at")
        domain_id = dictToStringKeyParam(dict: dict, key: "domain_id")
        from_age = dictToStringKeyParam(dict: dict, key: "from_age")
        id = dictToStringKeyParam(dict: dict, key: "id")
        kid_ratio = dictToStringKeyParam(dict: dict, key: "kid_ratio")
        middle_name = dictToStringKeyParam(dict: dict, key: "middle_name")
        name = dictToStringKeyParam(dict: dict, key: "name")
        other_name = dictToStringKeyParam(dict: dict, key: "other_name")
        price_for_members = dictToStringKeyParam(dict: dict, key: "price_for_members")
        price_for_non_members = dictToStringKeyParam(dict: dict, key: "price_for_non_members")
        registration_from = dictToStringKeyParam(dict: dict, key: "registration_from")
        registration_to = dictToStringKeyParam(dict: dict, key: "registration_to")
        schedule_from = dictToStringKeyParam(dict: dict, key: "schedule_from")
        schedule_to = dictToStringKeyParam(dict: dict, key: "schedule_to")
        status = dictToStringKeyParam(dict: dict, key: "status")
        teacher_ratio = dictToStringKeyParam(dict: dict, key: "teacher_ratio")
        time_from = dictToStringKeyParam(dict: dict, key: "time_from")
        time_to = dictToStringKeyParam(dict: dict, key: "time_to")
        to_age = dictToStringKeyParam(dict: dict, key: "to_age")
        updated_at = dictToStringKeyParam(dict: dict, key: "updated_at")
    

        if let data = dict["days_availability"] as? [String] {
            for obj in data {
                days_availability.append(obj)
            }
        }
    }
}
