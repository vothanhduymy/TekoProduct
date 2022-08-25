//
//  ViewController.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 23/08/2022.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var tblContent: UITableView!
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
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
