//
//  UserDetailViewCell.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 10/08/2022.
//

import UIKit

protocol UserDetailViewCellInterface: AnyObject {
    func didClickedLink(_ link: String)
}

class UserDetailViewCell: UICollectionViewCell {
    @IBOutlet weak var icon: UIImageView?
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var subTitle: UILabel?
    @IBOutlet weak var titleContainer: UIView?
    @IBOutlet weak var titleHeightConst: NSLayoutConstraint?
    
    weak var delegate: UserDetailViewCellInterface?
 
    override func awakeFromNib() {
        self.title?.font = UIFont.systemFont(ofSize: 18)
        self.title?.textColor = UIColor.black
    }
    
    func setupViews(data: DetailItemModel?) {
        if let _data = data {
            self.icon?.image = UIImage(named: _data.icon)
            if _data.isHyperLink {
                let attributedString = NSMutableAttributedString(string: _data.title)
                attributedString.addAttribute(.link, value: _data.title, range: NSRange(location: 0, length: _data.title.count))
                
                self.title?.attributedText = attributedString
                self.title?.isUserInteractionEnabled = true
                let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hyperLinkClicked(_:)))
                self.title?.addGestureRecognizer(guestureRecognizer)
            } else {
                self.title?.text = _data.title.isEmpty ? "NA" : _data.title
            }
            
            if _data.subTitle.isEmpty {
                self.titleHeightConst?.constant = 0
            } else {
                self.titleHeightConst?.constant = 32
                self.subTitle?.text = _data.subTitle
                self.titleContainer?.layer.cornerRadius = 16
                self.subTitle?.sizeToFit()
            }
        }
    }
    
    @objc func hyperLinkClicked(_ sender: Any) {
        if let link = title?.text, !link.isEmpty {
            print("UILabel clicked \(link)")
            delegate?.didClickedLink(link)
        }
    }
}
