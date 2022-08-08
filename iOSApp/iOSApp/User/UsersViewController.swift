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
    
    private func showError() {
        let alert = UIAlertController(title: "Có lỗi xảy ra!",
                                      message: "",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Đóng",
                                      style: .cancel,
                                      handler: { _ in
        }))

        present(alert, animated: true, completion: nil)
    }
}

extension UsersViewController: UsersViewModelOutput {
    
}

extension UsersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserItemViewCell", for: indexPath) as? UserItemViewCell {
            cell.backgroundColor = .white
            cell.setupViews(data: viewModel?.getItemAt(indexPath: indexPath), indexPath: indexPath)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension UsersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: viewModel?.cellHeight ?? 0)
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
}
