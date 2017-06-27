//
//  CityStateModel.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 26/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit
import ObjectMapper

class CityStateModel: NSObject, Mappable{
    
    var citySearched: String!
    var stateSearched: String!
    
    required convenience init?(map _map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        citySearched    <- map["Nome"]
        stateSearched   <- map["Estado"]
        
    }


}
