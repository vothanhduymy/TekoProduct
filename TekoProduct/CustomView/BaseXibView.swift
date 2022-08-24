//
//  BaseXibView.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 24/08/2022.
//

import UIKit

@IBDesignable
class BaseXibView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibCommonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibCommonInit()
    }
    
    func xibCommonInit() {
        let bundle = Bundle.init(for: type(of: self))
        guard let viewFromXib = bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}
