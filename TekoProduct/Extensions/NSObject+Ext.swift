//
//  NSObject+Ext.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 23/08/2022.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: Self.self)
    }
}
