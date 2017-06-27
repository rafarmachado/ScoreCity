//
//  ScoreModel.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 27/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit
import ObjectMapper

class ScoreModel: NSObject, Mappable{
    
    var cityName: String!
    var cityScore: String!
    
    required convenience init?(map _map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        cityName    <- map["cityName"]
        cityScore   <- map["cityScore"]
        
    }
}
