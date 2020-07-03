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
        
        let url = WebURL.BaseUrl+strURL
        
        var headers:HTTPHeaders = ["Authorization" : self.authorization,
                                  // "Content-Type":"application/json",
                                   "Content-Type":"multipart/form-data",
                                   "Accept": "application/json"]
        
        print("\nstrURL = \(url)")
        print("\nparams = \(params)")
        print("\nheaders = \(headers)")
        
        AF.request(url, method: .post,  parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
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
    
    public func requestPatch(strURL:String, params : [String:Any], success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        let url = WebURL.BaseUrl+strURL
        
        let headers:HTTPHeaders = ["Authorization" : self.authorization,
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
    
    public func requestGet(strURL:String, params : [String:Any], success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        strAuthToken =  UserDefaults.standard.string(forKey: UserDefaults.Keys.authToken) ?? ""
        
        let url = WebURL.BaseUrl + strURL
//        let headers:HTTPHeaders = ["authtoken" : strAuthToken]
        let headers:HTTPHeaders = ["Authorization" : self.authorization,
                                  // "Content-Type":"application/json",
                                   "Content-Type":"multipart/form-data",
                                   "Accept": "application/json"]

        //  "Content-Type":"Application/json"]
        
        //  manager.retrier = OAuth2Handler()
        
        print("\nheaders = \(headers)")
        print("\nparams = \(params)")
        print("\nstrAuthToken = \(strAuthToken)")
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { responseObject in
            
            self.StopIndicator()
            
            switch responseObject.result {
            case .success(let value):
                
                //                let resJson = JSON(responseObject.result.value!)
                //                success(resJson)
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
    /*
    public func uploadMultipartData(strURL:String, params : [String : AnyObject]?, imageData:Data?, fileName:String, key:String, mimeType:String, success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void){
        
        if !NetworkReachabilityManager()!.isReachable{
            self.StopIndicator()
            let app = UIApplication.shared.delegate as? AppDelegate
            let window = app?.window
            
            return
        }
        
        strAuthToken =  ""
        
        let url = WebURL.BaseUrl+strURL
        let headers = ["authtoken" : strAuthToken]
        // manager.retrier = OAuth2Handler()
        
        manager.upload(multipartFormData:{ multipartFormData in
            if let data = imageData{
                multipartFormData.append(data,
                                         withName:key,
                                         fileName:fileName,
                                         mimeType:mimeType)
            }
            for (key, value) in params! {
                let strValue = "\(value)"
                multipartFormData.append(strValue.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
            }},
                       usingThreshold:UInt64.init(),
                       to:url,
                       method:.post,
                       headers:headers,
                       encodingCompletion: { encodingResult in
                        switch encodingResult {
                        case .success(let upload, _, _):
                            upload.responseJSON { responseObject in
                                self.StopIndicator()
                                if responseObject.result.isSuccess {
                                    //                                        let resJson = JSON(responseObject.result.value!)
                                    //                                        success(resJson)
                                    do {
                                        let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                                        // Session Expire
                                        let dict = dictionary as! Dictionary<String, Any>
                                        if dict["status"] as? String ?? "" != "success"{
                                            
                                            if let msg = dict["message"] as? String{
                                                
                                            }
                                            
                                        }
                                        success(dictionary as! Dictionary<String, Any>)
                                    }catch{
                                    }
                                }
                                if responseObject.result.isFailure {
                                    let error : Error = responseObject.result.error!
                                    failure(error)
                                }
                            }
                        case .failure(let encodingError):
                            print(encodingError)
                            self.StopIndicator()
                            failure(encodingError)
                        }
        })
    }
    
    public func requestPostMultipartData(strURL:String, params : [String:Any], success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        if !NetworkReachabilityManager()!.isReachable{
            self.StopIndicator()
            let app = UIApplication.shared.delegate as? AppDelegate
            let window = app?.window
            return
        }
        
        
        let url = WebURL.BaseUrl+strURL
        let headers = ["authtoken" : strAuthToken,
                       "Content-Type":"multipart/form-data"]
        
        //manager.retrier = OAuth2Handler()
        
        manager.upload(multipartFormData:{ multipartFormData in
            
            for (key, value) in params {
                let strValue = "\(value)"
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }},
                       // usingThreshold:UInt64.init(),
            to:url,
            method:.post,
            headers:headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { responseObject in
                        self.StopIndicator()
                        if responseObject.result.isSuccess {
                            //                                        let resJson = JSON(responseObject.result.value!)
                            //                                        success(resJson)
                            do {
                                let dictionary = try JSONSerialization.jsonObject(with: responseObject.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                                // Session Expire
                                let dict = dictionary as! Dictionary<String, Any>
                                if dict["status"] as? String ?? "" != "success"{
                                    
                                    if let msg = dict["message"] as? String{
                                        
                                    }
                                }
                                success(dictionary as! Dictionary<String, Any>)
                            }catch{
                            }
                        }
                        if responseObject.result.isFailure {
                            let error : Error = responseObject.result.error!
                            failure(error)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    self.StopIndicator()
                    failure(encodingError)
                }
        })
    }
    */
    //MARK : -  Return Json Methods
    public func requestPostForJson(strURL:String, params : [String:Any], success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        
        let url = WebURL.BaseUrl+strURL
        let headers:HTTPHeaders = ["authtoken" : strAuthToken]
        
        print("\nstrURL = \(strURL)")
        print("\nparams = \(params)")
        print("\nstrAuthToken = \(strAuthToken)")
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { responseObject in
            switch responseObject.result {
            case .success(let value):
                do {
                    
                    let convertedString = String(data: responseObject.data!, encoding: String.Encoding.utf8) // the data will be converted to the string
                    let dict = self.convertToDictionary(text: convertedString!)
                    
                    if dict!["status"] as? String ?? "" != "success"{
                        if let msg = dict!["message"] as? String{
                            
                        }
                    }
                    print("\nResponce = \(dict!)")
                    success(dict!)
                    
                } catch {
                    
                }
                
            case .failure(let error):
                failure(error)
                self.StopIndicator()
            }
        }
    }
    // Return Json Methods
    public func requestGetForJson(strURL:String, params : [String:Any], success:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void ) {
        
        let url = WebURL.BaseUrl+strURL
        let headers:HTTPHeaders = ["authtoken" : strAuthToken]
        
        
        AF.request(url, method: .get, parameters: params, headers: headers).responseJSON { responseObject in
            self.StopIndicator()
            switch responseObject.result {
            case .success(let value):
                do {
                    
                    let convertedString = String(data: responseObject.data!, encoding: String.Encoding.utf8) // the data will be converted to the string
                    let dict = self.convertToDictionary(text: convertedString!)
                    if dict!["status"] as? String ?? "" != "success"{
                        if let msg = dict!["message"] as? String{
                            
                        }
                    }
                    success(dict!)
                    
                }catch{
                    
                }
                
            case .failure(let error):
                failure(error)
                self.StopIndicator()
            }
        }
    }
    
}
