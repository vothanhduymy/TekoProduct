//
//  Product.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 25/08/2022.
//

import Foundation
import ObjectMapper

class Product: Mappable, Codable, Equatable {
    var id: Int = 0
    var errorDescription: String = ""
    var name: String = ""
    var sku: String = ""
    var image: String = ""
    var color: Int?
    var isEditing: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, errorDescription, name, sku, image, color
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }

    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        id                  <- map["id"]
        errorDescription    <- map["errorDescription"]
        name                <- map["name"]
        sku                 <- map["sku"]
        image               <- map["image"]
        color               <- map["color"]
    }
}
