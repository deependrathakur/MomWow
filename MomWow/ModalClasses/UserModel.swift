//
//  UserModel.swift
//  MomWow
//
//  Created by Vijay sharma on 29/04/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import Foundation

struct UserModel {
  
    var email:String = ""
    var first_name:String = ""
    var gender:String = ""
    var id:Int = 0
    var last_name:String = ""
    var middle_name:String = ""
    var phone_number:String = ""
    var authToken:String = ""
    var user_type:String = ""

    init(dict:[String:Any]) {
                
        self.first_name = dict["first_name"] as? String ?? ""
        self.gender = dict["gender"] as? String ?? ""
        self.id = dict["id"] as? Int ?? 0
        self.email = dict["email"] as? String ?? ""
        self.last_name = dict["last_name"] as? String ?? ""
        self.middle_name = dict["middle_name"] as? String ?? ""
        self.phone_number = dict["phone_number"] as? String ?? ""
        self.authToken = dict["token"] as? String ?? ""
        self.user_type = dict["user_type"] as? String ?? ""
        
        self.saveUserInfoToUserdefaults()

    }
    
    func saveUserInfoToUserdefaults(){
        UserDefaults.standard.set( self.first_name, forKey: UserDefaults.Keys.first_name)
        UserDefaults.standard.set( self.gender, forKey: UserDefaults.Keys.gender)
        UserDefaults.standard.set( self.id, forKey: UserDefaults.Keys.id)
        UserDefaults.standard.set( self.email, forKey: UserDefaults.Keys.email)
        UserDefaults.standard.set( self.last_name, forKey: UserDefaults.Keys.last_name)
        UserDefaults.standard.set( self.middle_name, forKey: UserDefaults.Keys.middle_name)
        UserDefaults.standard.set( self.phone_number, forKey: UserDefaults.Keys.phone_number)
        UserDefaults.standard.set( self.authToken, forKey: UserDefaults.Keys.authToken)
        UserDefaults.standard.set( self.user_type, forKey: UserDefaults.Keys.user_type)
        UserDefaults.standard.synchronize()
    }
}

extension UserDefaults{

    enum Keys {
        
        static let first_name = "first_name"
        static let gender = "gender"
        static let id = "id"
        static let authToken  = "token"
        static let email  = "email"
        static let last_name = "last_name"
        static let middle_name = "middle_name"
        static let phone_number = "phone_number"
        static let user_type = "user_type"
        static let isRemember = "isRemember"
        
        static let rememberEmail = "rememberEmail"
        static let rememberPassword = "rememberPassword"
    }
}

