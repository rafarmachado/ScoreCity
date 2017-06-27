//
//  CitySearchServices.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 26/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class CitySearchServices: NSObject {

    let baseURL = (UIApplication.shared.delegate as! AppDelegate).BASE_URL
    
    func getCities(success: @escaping (_ parameter: Any?) -> Void,  failure: @escaping (_ parameter: Any?) -> Void, complete: @escaping () -> Void){
        
        let url = "\(baseURL)BuscaTodasCidades"
        
        AbstractServices.get(url: url, success: {(data: Any?) -> Void in
            
            let mapper = Mapper<CityStateModel>()
            let cities = mapper.mapArray(JSONString: data as! String)
            success(cities)
            
        }, failure: {(dataError: Any?) -> Void in
            failure(dataError)
            
        }, complete: {() -> Void in
            complete()
        })
        
    }

}
