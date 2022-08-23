//
//  Networking+Extension.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 23/08/2022.
//

import Foundation
import Networkable
import RxSwift

extension Endpoint {
    
//    var headers: [String : String]? {
//        let dicHeader: [String : String] = [
//            "app-id": API_ID,
//        ]
//        return dicHeader
//    }

    func buildRequestBody<T: Encodable>(_ body: T, encoder: JSONEncoder = JSONEncoder()) throws -> Data?{
        return try encoder.encode(body)
    }
}
