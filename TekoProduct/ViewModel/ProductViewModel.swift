//
//  ProductViewModel.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 25/08/2022.
//

import Foundation
import RxSwift

class ProductViewModel: BaseViewModel {
    let repo: DefaultTekoRepository
    private let disposeBag = DisposeBag()
    var products: [Product] = []
    var colors: [Color] = []
    var output: ProductViewModel.Output
    
    struct Output {
        var isLoading: PublishSubject<Bool>
        var responseError: PublishSubject<ResponseError>
        var getProducts: PublishSubject<Bool>
        var getColors: PublishSubject<Bool>
    }
    
    init(repository: DefaultTekoRepository = DefaultTekoRepository.shared) {
        repo = repository
        self.output = Output(
            isLoading: PublishSubject<Bool>(),
            responseError: PublishSubject<ResponseError>(),
            getProducts: PublishSubject<Bool>(),
            getColors: PublishSubject<Bool>()
        )
    }
    
    func getColors() {
        output.isLoading.onNext(true)
        repo.getColors()
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                self.output.isLoading.onNext(false)
                switch result {
                case .success(let response):
                    if let _colors = response.data?.data {
                        self.colors = _colors
                        self.output.getColors.onNext(true)
                    }
                case .failure(let error):
                    self.output.responseError.onNext(error.toResponseError())
                }
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.output.isLoading.onNext(false)
                self.output.responseError.onNext(error.toResponseError())
            })
            .disposed(by: disposeBag)
    }
    
    func getProducts() {
        output.isLoading.onNext(true)
        repo.getProducts()
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                self.output.isLoading.onNext(false)
                switch result {
                case .success(let response):
                    if let _products = response.data?.data {
                        self.products = _products
                        self.output.getProducts.onNext(true)
                    }
                case .failure(let error):
                    self.output.responseError.onNext(error.toResponseError())
                }
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.output.isLoading.onNext(false)
                self.output.responseError.onNext(error.toResponseError())
            })
            .disposed(by: disposeBag)
    }
}
