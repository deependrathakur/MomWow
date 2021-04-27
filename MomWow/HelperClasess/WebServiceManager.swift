//
//  WebServiceClass.swift
//  DemoProjectTemplet
//
//  Created by Amit.Rawal on 24/09/18.
//  Copyright © 2018 Amit.Rawal. All rights reserved.


// MARK: - Required things
//  install Alamofire with cocoapods * pod 'Alamofire'


import UIKit
import Alamofire

var strAuthToken : String = ""
let webServiceManager = WebServiceManager.sharedObject()
let objActivity = activityIndicator()

class WebServiceManager: NSObject {
    
    //MARK: - Shared object
    fileprivate var window = UIApplication.shared.keyWindow
    
    private static var sharedNetworkManager: WebServiceManager = {
        let networkManager = WebServiceManager()
        return networkManager
    }()
    
    // MARK: - Accessors
    class func sharedObject() -> WebServiceManager {
        return sharedNetworkManager
    }
    
    
    public let authorization:String = {
        
        let user = "admin"
        let password = "_d3aXzEG5g^m8K8G"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        
        return "Basic \(base64Credentials)"
    }()
    
    func showAlert(message: String = "", title: String , controller: UIWindow) {
        
        DispatchQueue.main.async(execute: {
            
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let subView = alertController.view.subviews.first!
            let alertContentView = subView.subviews.first!
            alertContentView.backgroundColor = UIColor.gray
            alertContentView.layer.cornerRadius = 20
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
        })
    }
    
    //MARK: - Convert String to Dict
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func isNetworkAvailable() -> Bool{
        if !NetworkReachabilityManager()!.isReachable{
            return false
        }else{
            return true
        }
    }
    
    func StartIndicator(){
        DispatchQueue.main.async {
            objActivity.startActivityIndicator()
        }
    }
    
    func StopIndicator(){
        DispatchQueue.main.async {
            objActivity.stopActivity()
        }
    }
}

extension WebServiceManager {
    
    public func requestPost(strURL:String, params : [String:Any]?, success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        let urlDict = params ?? ["":""]
        let urlString = changeParamToURL(url: strURL, param: params ?? urlDict)
        
        let newURL = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        
        
        let searchURL = URL(string: newURL ?? "")
        var token:String?
        if let tokens = UserDefaults.standard.value(forKey: UserDefaults.Keys.authToken) as? String {
            token = tokens
        }
        
        
        
        let headers:HTTPHeaders = ["Authorization" : token ?? "",
                                   // "Content-Type":"application/json",
            //"Content-Type":"multipart/form-data",
            // "Accept": "application/json"
        ]
        
        AF.request(searchURL!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result)
            
            switch response.result {
            case .success(let value):
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    // Session Expire
                    let dict = dictionary as! Dictionary<String, Any>
                    if dict["status"] as? String ?? "" != "success"{
                        if let msg = dict["message"] as? String{
                            print(msg)
                        }
                    }
                    print("\n response = \(dictionary)")
                    success(dictionary as! Dictionary<String, Any>)
                    self.StopIndicator()
                }catch{
                    
                }
            case .failure(let error):
                failure(error)
                self.StopIndicator()
            }
        }
    }
    
    public func requestPost2(strURL:String, params : [String:Any]?, success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        let urlDict = params ?? ["":""]
        let urlString = urlDict//changeParamToURL(url: strURL, param: params ?? urlDict)
        
        var token:String?
        if let tokens = UserDefaults.standard.value(forKey: UserDefaults.Keys.authToken) as? String {
            token = tokens
        }
        
        let headers:HTTPHeaders = ["Authorization" : token ?? ""]
        
        AF.request(strURL, method: .post, parameters: urlString, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result)
            
            switch response.result {
            case .success(let value):
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    // Session Expire
                    let dict = dictionary as! Dictionary<String, Any>
                    if dict["status"] as? String ?? "" != "success"{
                        if let msg = dict["message"] as? String{
                            print(msg)
                        }
                    }
                    print("\n response = \(dictionary)")
                    success(dictionary as! Dictionary<String, Any>)
                    self.StopIndicator()
                }catch{
                    
                }
            case .failure(let error):
                failure(error)
                self.StopIndicator()
            }
        }
    }
    
    func changeParamToURL(url: String, param: [String:Any]) -> String {
        var url = url
        var index = -1
        for obj in param {
            index = index+1
            let key = obj.key
            let value = obj.value
            if index == 0 {  url = "\(url)\(key)=\(value)" } else {  url = "\(url)&\(key)=\(value)" } }
        return url
    }
    
    public func requestPatch(strURL:String, params : [String:Any], success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        let url = strURL
        
        let headers:HTTPHeaders = ["Authorization" : UserDefaults.standard.string(forKey: UserDefaults.Keys.authToken) ?? "",
                                   // "Content-Type":"application/json",
            "Content-Type":"multipart/form-data",
            "Accept": "application/json"]
        
        print("\nstrURL = \(url)")
        print("\nparams = \(params)")
        print("\nheaders = \(headers)")
        
        AF.request(url, method: .patch,  parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    // Session Expire
                    let dict = dictionary as! Dictionary<String, Any>
                    if dict["status"] as? String ?? "" != "success"{
                        if let msg = dict["message"] as? String{
                            print(msg)
                        }
                    }
                    print("\n response = \(dictionary)")
                    success(dictionary as! Dictionary<String, Any>)
                    self.StopIndicator()
                }catch{
                    
                }
            case .failure(let error):
                failure(error)
                self.StopIndicator()
            }
        }
    }
    
    public func requestGet(strURL:String, success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        let headers:HTTPHeaders = ["Authorization" : UserDefaults.standard.string(forKey: UserDefaults.Keys.authToken) ?? ""]
        AF.request(strURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { responseObject in
            self.StopIndicator()
            switch responseObject.result {
            case .success(let value):
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    // Session Expire
                    let dict = dictionary as! Dictionary<String, Any>
                    if dict["status"] as? String ?? "" != "success"{
                        if let msg = dict["message"] as? String{
                        }
                    }
                    print("\n response = \(dictionary)")
                    success(dictionary as! Dictionary<String, Any>)
                }catch{
                }
            case .failure(let error):
                failure(error)
                self.StopIndicator()
            }
        }
    }
    
    func uploadMultipartImageAPI2(param:[String: Any], arrImage: [String : UIImage], URlName:String, success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void){
        
        var token:String?
        if let tokens = UserDefaults.standard.value(forKey: UserDefaults.Keys.authToken) as? String {
            token = tokens
        }
        let headers:HTTPHeaders = ["Authorization" : token ?? ""]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in param {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for (key, value) in arrImage {
                guard let imgData = value.jpegData(compressionQuality: 1) else { return }
                multipartFormData.append(imgData, withName: key, fileName: "image.jpeg", mimeType: "image/jpeg")
            }
            
            
        },to: URlName, usingThreshold: UInt64.init(),
          method: .put,
          headers: headers).responseJSON{ responseObject in
            
            print(responseObject.result)
            
            switch responseObject.result {
            case .success(let value):
                
//                let json = JSON(value)
//                print(json)
                
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    success(dictionary as! Dictionary<String, Any>)
                    print(dictionary)
                }catch{
                    if let error : Error = responseObject.error{
                        failure(error)
                        let str = String(decoding:  responseObject.data!, as: UTF8.self)
                        print("PHP ERROR : \(str)")
                    }
                    
                }
                
            case .failure(let error):
                
                print(error)
                
                if let error : Error = responseObject.error{
                    failure(error)
                    if let error = responseObject.data{
                        let str = String(decoding:  error, as: UTF8.self)
                        print("PHP ERROR : \(str)")
                    }
                }
                
            }
        }
    }
    
    public func requestPut(strURL:String, params : [String:Any]?, success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        let urlDict = params ?? ["":""]
        let urlString = urlDict

        var token:String?
        if let tokens = UserDefaults.standard.value(forKey: UserDefaults.Keys.authToken) as? String {
            token = tokens
        }

        let headers:HTTPHeaders = ["Authorization" : token ?? ""]

        AF.request(strURL, method: .put, parameters: urlString, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result)

            switch response.result {
            case .success(let value):
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    // Session Expire
                    let dict = dictionary as! Dictionary<String, Any>
                    if dict["status"] as? String ?? "" != "success"{
                        if let msg = dict["message"] as? String{
                            print(msg)
                        }
                    }
                    print("\n response = \(dictionary)")
                    success(dictionary as! Dictionary<String, Any>)
                    self.StopIndicator()
                }catch{

                }
            case .failure(let error):
                failure(error)
                self.StopIndicator()
            }
        }
    } }
