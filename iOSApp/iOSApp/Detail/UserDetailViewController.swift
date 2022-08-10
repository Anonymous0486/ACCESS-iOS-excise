//
//  UserDetailViewController.swift
//  iOSApp

//  Created by thanh nguyen trong on 09/08/2022.
//


import UIKit
import SDWebImage

class UserDetailViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var avatar: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var bio: UILabel?
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var indicatorView: UIActivityIndicatorView?
    
    //MARK: - Constants
    
    //MARK:- Properties / Variables
    fileprivate var viewModel: UserDetailViewModelInput?
    fileprivate let width: CGFloat = UIScreen.main.bounds.width

    //MARK: Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.avatar?.layer.cornerRadius = 86
        toggleLoadingView(false)
        
        viewModel?.viewDidLoad()
    }
    
    private func toggleLoadingView(_ isHidden: Bool) {
        self.indicatorView?.isHidden = isHidden
        if isHidden {
            self.indicatorView?.stopAnimating()
        } else {
            self.indicatorView?.startAnimating()
        }
    }
    
    private func showError(err: String) {
        let alert = UIAlertController(title: "ERROR!",
                                      message: err,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "CLOSE",
                                      style: .cancel,
                                      handler: { _ in
        }))

        present(alert, animated: true, completion: nil)
    }
}

extension UserDetailViewController: UserDetailViewModelOutput {
    func didGetUserDetail(user: UserDetailModel?, err: String) {
        DispatchQueue.main.async { [weak self] in
            self?.toggleLoadingView(true)
            if let _user = user {
                self?.avatar?.sd_setImage(with: URL(string: _user.avatarUrl), placeholderImage: UIImage(named: "ic_user"))
                self?.name?.text = _user.name
                self?.bio?.text = _user.bio
                self?.collectionView?.reloadData()
            } else {
                self?.showError(err: err)
            }
        }
    }
}

extension UserDetailViewController: UserDetailViewCellInterface {
    func didClickedLink(_ link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}

extension UserDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserDetailViewCell", for: indexPath) as? UserDetailViewCell {
            cell.backgroundColor = .white
            cell.delegate = self
            cell.setupViews(data: viewModel?.getItemAt(indexPath: indexPath))
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension UserDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}

extension UserDetailViewController {
    class func createViewController(with username: String) -> UserDetailViewController? {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else {
            return nil
        }
        
        let viewModel = UserDetailViewModel(with: username)
        viewModel.output = viewController
        viewController.viewModel = viewModel
        
        return viewController
    }
}
