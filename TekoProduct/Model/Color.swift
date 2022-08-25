//
//  Color.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 25/08/2022.
//

import Foundation
import ObjectMapper

struct Color: Mappable, Codable {
    var id: Int?
    var name: String?
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }
}
