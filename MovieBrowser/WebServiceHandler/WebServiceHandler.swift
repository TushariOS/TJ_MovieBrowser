//
//  WebServiceHandler.swift
//  MovieBrowser
//
//  Created by Tushar on 27/10/17.
//  Copyright © 2017 Tushar. All rights reserved.
//

import Foundation
import UIKit

class WebserviceHandler{

    func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Data?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }
    
    func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Data?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }
    
    func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Data?) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    
    func getClientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        
     //   let access_token =  UserDefaults.standard.value(forKey: "AccessToken") as! String
        
        var paramString = ""
        if let params = params {
            
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
        }
        let url = URL.init(string: path+"?"+paramString)! //else {return}
        let request = NSMutableURLRequest(url: url)
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")

        return request
    }
    
    func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        
        let access_token =  UserDefaults.standard.value(forKey: "AccessToken") as! String
        
        var paramString = ""
        if let params = params {
            
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
        }
        let url = URL.init(string: path)! //else {return}
        let request = NSMutableURLRequest(url: url)
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = paramString.data(using: .utf8)
        
        request.addValue("bearer "+access_token, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (Bool, Data) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                
              //  let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion( true, data)
                } else {
                    completion(false, data)
                }
            }
            }.resume()
    }
}

extension WebserviceHandler{
    
    var rootView: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }
    
    func showAlert(message:String){
        
        let alertController = UIAlertController(title: "TMDB", message: message, preferredStyle: .alert)
        
        // Create OK button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        alertController.addAction(OKAction)
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        
        // Present Dialog message
        
        rootView?.present(alertController, animated: true, completion:nil)
        
    }
    
    
    
    
    
    
}
