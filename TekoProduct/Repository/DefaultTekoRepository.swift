//
//  DefaultTekoRepository.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 25/08/2022.
//

import Foundation
import Networkable
import RxSwift

protocol TekoRepository {
    func getColors() -> Observable<Result<[Color], Error>>
    func getProducts() -> Observable<Result<[Product], Error>>
}

final class DefaultTekoRepository: TekoRepository {
    static let shared = DefaultTekoRepository()
    
    var dataService: DataService
    
    init(dataService: DataService = RxDataService()) {
        self.dataService = dataService
    }
    
    func getColors() -> Observable<Result<[Color], Error>> {
        return dataService.buildObservable(APIEndpoint.getColors)
    }
    
    func getProducts() -> Observable<Result<[Product], Error>> {
        return dataService.buildObservable(APIEndpoint.getProducts)
    }
}

extension DefaultTekoRepository {
    
    enum APIEndpoint: Endpoint {
        case getProducts
        case getColors
        
        var url: String {
            let apiBaseUrl = BASE_URL
            switch self {
            case .getProducts:
                let result: String = apiBaseUrl + "/products"
                return result
            case .getColors:
                let result: String = apiBaseUrl + "/colors"
                return result
            }
        }
        
        var method: Networkable.Method {
            switch self {
            case .getProducts, .getColors:
                return .get
            }
        }
        
        func body() throws -> Data? {
            switch self {
            case .getProducts, .getColors:
                return nil
            }
        }
    }
}
