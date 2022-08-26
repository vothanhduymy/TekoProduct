//
//  ProductTableViewCell.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 23/08/2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    var product: Product!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtErrorDes: UITextField!
    @IBOutlet weak var txtSku: UITextField!
    @IBOutlet weak var txtColor: UITextField!

    @IBOutlet weak var btnChangeColor: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    var didEdit: (() -> Void)?
    var didChangeColor: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txtSku.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func btnEditTapped(_ sender: Any) {
        didEdit?()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == txtName {
            product.name = textField.text?.trimmed ?? ""
        } else if textField == txtSku {
            product.sku = textField.text?.trimmed ?? ""
        }
        reloadData()
    }
    
    @IBAction func btnChangeColorTapped(_ sender: Any) {
        if product.isEditing {
            didChangeColor?()
        }
    }
    
    func reloadData() {
        txtName.isUserInteractionEnabled = product.isEditing
        txtSku.isUserInteractionEnabled = product.isEditing
        
        imgImage.nukeLoadImage(url: URL(string: product.image))
        txtName.text = product.name
        txtErrorDes.text = product.errorDescription
        txtSku.text = product.sku
        btnEdit.setImage(UIImage(named: product.isEditing ? "ic_checked" : "ic_edit"), for: .normal)
//        txtColor.text = product.color?.name
    }
}
