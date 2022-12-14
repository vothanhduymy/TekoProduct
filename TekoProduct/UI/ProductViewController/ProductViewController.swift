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
import ActionSheetPicker_3_0

class ProductViewController: UIViewController {
    @IBOutlet weak var tblContent: UITableView!
    let viewModel: ProductViewModel = ProductViewModel()
    private let disposeBag = DisposeBag()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tblContent.addSubview(refreshControl)
        
//        tblContent.addInfiniteScrolling { [weak self] in
//            guard let self = self else { return }
//        }
        
        viewModel.getColors()
        
        bindViewModel()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        let popup: SubmitChangesView = SubmitChangesView()
        popup.contentCornerRadius = 5
        popup.products = viewModel.editedProducts
        popup.colors = viewModel.colors
        popup.didClose = { [weak self] in
            guard let self = self else { return }
            self.viewModel.editedProducts.removeAll()
        }
        popup.showPopup()
    }
    
    @objc private func refreshData() {
        viewModel.getProducts()
    }
    
    private func bindViewModel() {
        viewModel.output.getColors
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSuccess in
                guard let self = self else { return }
                self.viewModel.getProducts()
            }).disposed(by: disposeBag)
        
        viewModel.output.getProducts
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isShowsInfiniteScrolling in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
//                self.tblContent.infiniteScrollingView.stopAnimating()
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
        let product = viewModel.products[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell
        if cell ==  nil {
            cell = Bundle.main.loadNibNamed("ProductTableViewCell", owner: self)?.first as? ProductTableViewCell
        }
        cell?.product = product
        cell?.reloadData()
        cell?.txtColor.text = viewModel.colors.first(where: { $0.id == product.color })?.name
        
        cell?.didEdit = { [weak self] in
            guard let self = self else { return }
            product.isEditing.toggle()
            if product.isEditing {
                self.viewModel.editedProducts.append(product)
                //                self.viewModel.editedProducts = self.viewModel.editedProducts.withoutDuplicates { p in
                //                    p.id
                //                }
                //
                self.viewModel.editedProducts.removeDuplicates()
            }
            tableView.reloadData()
        }
        
        cell?.didChangeColor = { [weak self] in
            guard let self = self else { return }
            let picker: ActionSheetStringPicker = ActionSheetStringPicker(title: "Choose color", rows: self.viewModel.colors.map({ $0.name }), initialSelection: 0, doneBlock: { [weak self] _, _selectedIndex, _ in
                guard let self = self else { return }
                product.color = self.viewModel.colors[_selectedIndex].id
                tableView.reloadData()
            }, cancel: { _ in
                
            }, origin: cell?.btnChangeColor)
            picker.show()
        }
        
        return cell ?? UITableViewCell()
    }
}

extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}
