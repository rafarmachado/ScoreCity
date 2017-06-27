//
//  scoreFromCityServices.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 27/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ScoreFromCityServices: NSObject {
    //MARK: - Variables
    let baseURL = (UIApplication.shared.delegate as! AppDelegate).BASE_URL

    //MARK: - Services
    func scoreFromCity(city: CityStateModel, success: @escaping (_ parameter: Any?) -> Void,  failure: @escaping (_ parameter: Any?) -> Void, complete: @escaping () -> Void){
        
        let dictionary: [String:String] = [
            "Nome" : city.citySearched!,
            "Estado" : city.stateSearched!
        ]
        
        print(dictionary)
        
        let url = "\(baseURL)BuscaPontos"
        
        AbstractServices.post(url: url, parameters: dictionary as [String : NSObject], success: {(data: Any?) -> Void in
            let scoreSuccess = data as! String
            success(scoreSuccess)
            
        }, failure: {(dataError: Any?) -> Void in
            failure(dataError)
            
        }, complete: {() -> Void in
            complete()
        })
        
    }

}

