//
//  AppShareClass.swift
//  Test
//
//  Created by Harshit on 27/02/20.
//  Copyright © 2020 Deependra. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Identifire viewcontroller and storyboard

//colors
let appColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
let grayColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
let whiteColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
let blackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

//storyboardName
let mainStoryBoard = "Main"
//UIViewController name
let signUpVC = "SignUpViewController"
let loginVC = "LoginViewController"
let forgotPassword = "ForgotPasswordViewController"
let otpVC = "OTPViewController"
let resetPassword = "ResetPasswordViewController"

let homeStoryBoard = "Home"
//UIViewController name

//cell


//MARK: - Navigation Method
func goToNextVC(storyBoardID: String, vc_id: String, currentVC: UIViewController) {
    let vc = UIStoryboard.init(name: storyBoardID, bundle: Bundle.main).instantiateViewController(withIdentifier: vc_id)
    currentVC.navigationController?.pushViewController(vc, animated: true)
}

////MARK: - DATE TIME PICKER
func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
    let objDateformat: DateFormatter = DateFormatter()
    objDateformat.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS+00:00"
    let strTime: String = objDateformat.string(from: dateToConvert as Date)
    let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
    let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
    let strTimeStamp: String = "\(milliseconds)"
    return strTimeStamp
}

func getTimeFromTime(date:Date) -> String {
    let formatter  = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy hh:mm a"
    formatter.dateFormat = "MMM DD yyyy hh:mm a"
    formatter.dateFormat = "E, d MMM yyyy hh:mm a"

    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
    let formatedDate: String = formatter.string(from: date)
    return formatedDate
}
