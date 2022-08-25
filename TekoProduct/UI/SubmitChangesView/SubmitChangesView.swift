//
//  SubmitChangesView.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 24/08/2022.
//

import UIKit

class SubmitChangesView: PopupView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblContent: UITableView!
    @IBOutlet weak var btnOK: UIButton!
    var products: [Product] = []
    @IBOutlet weak var heightTbl: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    @IBAction func btnOKTapped(_ sender: Any) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        tblContent.dataSource = self
        tblContent.delegate = self
        
        heightTbl.constant =
    }
}

extension SubmitChangesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SubmitProductTableViewCell") as? SubmitProductTableViewCell
        if cell ==  nil {
            cell = Bundle.main.loadNibNamed("SubmitProductTableViewCell", owner: self)?.first as? SubmitProductTableViewCell
        }
        
        return cell ?? UITableViewCell()
    }
}

extension SubmitChangesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
