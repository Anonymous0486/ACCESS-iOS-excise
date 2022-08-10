//
//  UsersViewController.swift
//  iOSApp

//  Created by thanh nguyen trong on 08/08/2022.
//


import UIKit

class UsersViewController: UIViewController {

    // MARK:- IBOutlets
    @IBOutlet weak var collectionView: UICollectionView?
    
    // MARK: - Constants
    
    // MARK:- Properties / Variables
    fileprivate var viewModel: UsersViewModelInput?
    fileprivate let width: CGFloat = UIScreen.main.bounds.width
    
    // MARK: Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
        
        title = "iOS Demo App"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        print("View will appear!!!!")
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

extension UsersViewController: UsersViewModelOutput {
    func didGetUserList(success: Bool, err: String) {
        DispatchQueue.main.async { [weak self] in
            if success {
                self?.collectionView?.reloadData()
            } else {
                self?.showError(err: err)
            }
        }
    }
}

extension UsersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserItemViewCell", for: indexPath) as? UserItemViewCell {
                cell.backgroundColor = .white
                cell.setupViews(data: viewModel?.getItemAt(indexPath: indexPath), indexPath: indexPath)
                
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserLoadingViewCell", for: indexPath) as? UserLoadingViewCell {
                cell.backgroundColor = .white
                cell.indicatorView?.startAnimating()
                viewModel?.loadMore()
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select user at index: \(indexPath.row)")
        guard let user = viewModel?.getItemAt(indexPath: indexPath) else { return }
        
        if let vc = UserDetailViewController.createViewController(with: user.name) {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension UsersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: indexPath.section == 0 ? 82 : 52)
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

extension UsersViewController {
    class func createViewController() -> UsersViewController? {
        let storyboard = UIStoryboard(name: "Users", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UsersViewController") as? UsersViewController else {
            return nil
        }
        
        let viewModel = UsersViewModel()
        viewModel.output = viewController
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    class func presentAsRoot() {
        let storyboard = UIStoryboard(name: "Users", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UsersViewController") as? UsersViewController else {
            return
        }
        
        let viewModel = UsersViewModel()
        viewModel.output = viewController
        viewController.viewModel = viewModel
        
        UIWindow.key?.rootViewController = viewController
    }
}
