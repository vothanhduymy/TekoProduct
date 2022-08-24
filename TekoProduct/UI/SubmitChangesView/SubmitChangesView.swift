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
        
    }
}
