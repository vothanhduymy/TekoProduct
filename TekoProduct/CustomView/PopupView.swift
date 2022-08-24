//
//  PopupView.swift
//  TekoProduct
//
//  Created by Vo Thanh Duy My on 24/08/2022.
//

import UIKit

class PopupView: BaseXibView {
    @IBOutlet weak public var vwContent: UIView!
    public var isModal: Bool = true
    var contentCornerRadius: CGFloat = 0
    var contentAlpha: CGFloat = 0.5
    
    private var containerViewController: UIViewController?
    private var vwBg: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBgViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBgViews()
    }
    
    private func setupBgViews() {
        let screen = UIScreen.main
        let frame = CGRect(x: screen.bounds.origin.x,
                           y: screen.bounds.origin.y,
                           width: screen.bounds.size.width,
                           height: screen.bounds.size.height + 50)
        
        self.vwBg = UIView.init(frame: frame)
        
        // alpha background
        self.vwBg?.backgroundColor = UIColor.black
        self.vwBg?.alpha = contentAlpha
        
        let view = self.vwContent.superview!
        view.addSubview(self.vwBg!)
        view.sendSubviewToBack(self.vwBg!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwContent.layer.masksToBounds = true
        self.vwContent.layer.cornerRadius = contentCornerRadius
        
        if self.isModal {
            let tap = UITapGestureRecognizer.init(target: self,
                                                  action: #selector(self.dismissPopup))
            self.vwBg?.removeGestureRecognizer(tap)
            self.vwBg?.addGestureRecognizer(tap)
        }
    }
    
    func showPopup() {
        showPopupWithCompletion(nil)
    }
    
    func showPopupWithCompletion(_ completion: ((Bool) -> Void)?) {
        showPopupWithCompletion(completion, onController: Util.topViewController())
    }
    
    func showPopupWithCompletion(_ completion: ((Bool) -> Void)?, onController viewController: UIViewController?) {
        guard let toView = viewController?.view else {
            print("Error: Popup viewController not found")
            return
        }
        
        self.frame = CGRect(x: 0, y: -20, width: toView.frame.size.width, height: toView.frame.size.height)
        self.alpha = 0.0
        toView.addSubview(self)
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = 1.0
            self.frame = CGRect(x: 0, y: 0, width: toView.frame.size.width, height: toView.frame.size.height)
        }) { finished in
            if let completion = completion {
                completion(finished)
            }
        }
    }
    
    @objc private func dismissPopup() {
        self.dismissPopupWithCompletion(nil)
    }

    func dismissPopupWithCompletion(_ completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = 0.0
        }) { finished in
            self.removeFromSuperview()
            if let completion = completion {
                completion(finished)
            }
        }
    }

    
    
}
