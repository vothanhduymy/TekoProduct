//
//  Util.swift
//  Dummy
//
//  Created by Vo Thanh Duy My on 23/06/2022.
//

import Foundation
import NVActivityIndicatorView

class Util {
    static func topViewController() -> UIViewController? {
        if let rootController = UIWindow.key?.rootViewController {
            var currentController: UIViewController! = rootController
            while currentController.presentedViewController != nil {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
    
    static func showLoading() {
        let activityData: ActivityData = ActivityData(size: CGSize(width: 30, height: 30), type: .ballSpinFadeLoader, color: .lightGray)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    static func hideLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
