//
//  AbstractServices.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 26/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class AbstractServices: NSObject {
    
    class func post(url: String, parameters: [String:NSObject]?, success: @escaping (_ parameter: Any?) -> Void,  failure: @escaping (_ parameter: Any?) -> Void, complete: @escaping () -> Void){
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseString { response in
            
            complete()
            
            switch(response.result) {
            case .success(_):
                success(response.result.value)
                break
            case .failure(let error):
                if let data = response.data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: data, options:
                            JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        if let message: String = responseJSON?["message"] as? String{
                            if !message.isEmpty {
                                failure(message)
                            }
                        }
                    } catch let jsonError {
                        failure(jsonError)
                    }
                }
                else{
                    failure(error)
                }
                break
            }
        }
    }
    
    class func get(url: String, success: @escaping (_ parameter: Any?) -> Void,  failure: @escaping (_ parameter: Any?) -> Void, complete: @escaping () -> Void){
        
        Alamofire.request(url, headers: nil).validate(statusCode: 200..<300).responseString { response in
            
            complete()
            
            switch(response.result) {
            case .success(_):
                success(response.result.value)
                break
            case .failure(let error):
                if let data = response.data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: data, options:
                            JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        if let message: String = responseJSON?["message"] as? String{
                            if !message.isEmpty {
                                failure(message)
                            }
                        }
                    } catch let jsonError {
                        failure(jsonError)
                    }
                }
                else{
                    failure(error)
                }
                break
            }
        }
    }
    
}
