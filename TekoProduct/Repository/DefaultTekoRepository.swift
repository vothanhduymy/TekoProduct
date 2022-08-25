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
    func getProducts() -> Observable<Result<BaseResponse<[Product]>, Error>>
    func getColors() -> Observable<Result<BaseResponse<[Color]>, Error>>
}

final class DefaultTekoRepository: TekoRepository {
    static let shared = DefaultTekoRepository()
    
    var dataService: DataService
    
    init(dataService: DataService = RxDataService()) {
        self.dataService = dataService
    }
    
    func getProducts() -> Observable<Result<BaseResponse<[Product]>, Error>> {
        return dataService.buildObservable(APIEndpoint.getProducts)
    }
    
    func getColors() -> Observable<Result<BaseResponse<[Color]>, Error>> {
        return dataService.buildObservable(APIEndpoint.getColors)
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
