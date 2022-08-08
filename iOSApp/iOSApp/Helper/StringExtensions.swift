//
//  StringExtensions.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 08/08/2022.
//

import UIKit

extension String {
    func width(_ font: UIFont = UIFont.systemFont(ofSize: 16)) -> CGFloat {
        return self.size(withAttributes: [NSAttributedString.Key.font: font]).width
    }
}
