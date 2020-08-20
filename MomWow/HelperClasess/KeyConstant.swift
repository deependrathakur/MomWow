//
//  KeyConstant.swift
//  Mualab
//
//  Created by MINDIII on 10/16/17.
//  Copyright © 2017 MINDIII. All rights reserved.
//

import Foundation

//user Info
  let kAuthToken = "authToken"
  let kUserId = "userId"
  let kUserName = "userName"
  let kFullName = "fullName"
  let kEmail = "email"
  let kContact = "contact"

  let kCountryCode = "countryCode"
  let kProfileImage = "profileImage"
  let kCoverImage = "coverImage"
  let kAddress = "address"
  let kLatitude = "latitude"
  let kLongitude = "longitude"
  let kUserType = "userType"
  let kDiscription = "description"
  let kDOB = "DOB"
  let isCatagorySelected = "catagorySelected"
  let kFirebaseToken = "firebaseToken"
  let kPassword = "password"
  let kMyChatId = "myChatId"
  let kGender = "gender"
  let kIsRemember = "remember"

  let kCurrentAddress = "currentAddress"
  let kCurrentLatitude = "currentLatitude"
  let kCurrentLongitude = "currentLongitude"
//StoryBoardKeys
  let MAIN = "Main"
  let uploadingStart = "Uploading Start"
//FBData
  let kFBId = "FBId"
  let kFBEmail = "FBEmail"
  let kFBName = "FBName"
  let kFBProfileImage = "FBProfileImage"
//TwitterData
  let kTwitterUserId = "twitterUserId"
  let kChatDataBase = "meaple_chat"
  let kLastMessageDataBase = "Last_Message"
  let wrongUsername = "Invalid Username"
  let wrongPassword = "Invalid Password"
  let alreadyExist = "already exist"
  let kCloseAddFeed = "close Add Feed"

 // WebService

let GMSPlaceApiKey = "AIzaSyDTiiUSJuP_IkrcV1mfOUyXTkzbOU0ihRI"
  
extension UserDefaults{
    enum dateKeys {
        static let currentDate = "currentDate"
        static let nextDate = "nextDate"
    }
    enum lunchKey {
        static let hasLaunchedOnce = "HasLaunchedOnce"
    }
}


