//
//  UserItemViewCell.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 08/08/2022.
//

import UIKit
import SDWebImage

class UserItemViewCell: UICollectionViewCell {
    @IBOutlet weak var icon: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var titleContainer: UIView?
    @IBOutlet weak var titleHeightConst: NSLayoutConstraint?
    
    override func awakeFromNib() {
        self.name?.font = UIFont.systemFont(ofSize: 16)
        self.name?.textColor = UIColor.black
        
        self.icon?.layer.cornerRadius = 32
    }
    
    func setupViews(data: UserModel?, indexPath: IndexPath) {
        if let _data = data {
            self.icon?.image = UIImage(named: "ic_user")
//            self.icon?.sd_setImage(with: URL(string: _data.avatarUrl), placeholderImage: UIImage(named: "ic_user"))
            self.name?.text = _data.name
            
            if _data.title.isEmpty {
                self.titleHeightConst?.constant = 0
            } else {
                self.titleHeightConst?.constant = 32
                self.title?.text = _data.title
                self.titleContainer?.layer.cornerRadius = 16
                self.title?.sizeToFit()
            }
        }
    }
    
}
