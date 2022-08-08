//
//  UIWindowExtensions.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 08/08/2022.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
