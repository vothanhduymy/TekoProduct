//
//  SubmitProductTableViewCell.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 23/08/2022.
//

import UIKit

class SubmitProductTableViewCell: UITableViewCell {
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtErrorDes: UITextField!
    @IBOutlet weak var txtSku: UITextField!
    @IBOutlet weak var txtColor: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func reloadData(_ product: Product) {
        imgImage.nukeLoadImage(url: URL(string: product.image))
        txtName.text = product.name
        txtErrorDes.text = product.errorDescription
        txtSku.text = product.sku
        txtColor.text = product.color?.name
    }
}
