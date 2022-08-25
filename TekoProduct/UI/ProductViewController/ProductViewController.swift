//
//  ViewController.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 23/08/2022.
//

import UIKit
import RxSwift
import RxCocoa
import SVPullToRefresh

class ProductViewController: UIViewController {
    @IBOutlet weak var tblContent: UITableView!
    let viewModel: ProductViewModel = ProductViewModel()
    private let disposeBag = DisposeBag()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tblContent.addSubview(refreshControl)
        
        tblContent.addInfiniteScrolling { [weak self] in
            guard let self = self else { return }
        }
        viewModel.getProducts()
        
        bindViewModel()
    }
    
    @objc private func refreshData() {
        viewModel.getProducts()
    }
    
    private func bindViewModel() {
        viewModel.output.getProducts
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isShowsInfiniteScrolling in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
                self.tblContent.infiniteScrollingView.stopAnimating()
                self.tblContent.reloadData()
                self.tblContent.showsInfiniteScrolling = isShowsInfiniteScrolling
            }).disposed(by: disposeBag)
        
        viewModel.output.responseError
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self,
                      let error = event.element else { return }
                self.showAlert(title: error.error, message: error.data?.data)
            }.disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe { event in
                guard let loading = event.element else { return }
                if loading {
                    Util.showLoading()
                } else {
                    Util.hideLoading()
                }
            }.disposed(by: disposeBag)
    }
}

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell
        if cell ==  nil {
            cell = Bundle.main.loadNibNamed("ProductTableViewCell", owner: self)?.first as? ProductTableViewCell
        }
        
        return cell ?? UITableViewCell()
    }
}

extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
