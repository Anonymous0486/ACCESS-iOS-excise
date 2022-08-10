//
//  UserLoadingViewCell.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 10/08/2022.
//

import UIKit

class UserLoadingViewCell: UICollectionViewCell {
    @IBOutlet weak var indicatorView: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        indicatorView?.startAnimating()
    }
}
