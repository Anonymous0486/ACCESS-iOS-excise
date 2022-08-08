//
//  UserDetailViewController.swift
//  iOSApp

//  Created by thanh nguyen trong on 09/08/2022.
//


import UIKit

class UserDetailViewController: UIViewController {

    //MARK:- IBOutlets
    
    //MARK: - Constants
    
    //MARK:- Properties / Variables
    fileprivate var viewModel: UserDetailViewModelInput?

    //MARK: Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
}

extension UserDetailViewController: UserDetailViewModelOutput {
    
}

extension UserDetailViewController {
    class func createViewController() -> UserDetailViewController? {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else {
            return nil
        }
        
        let viewModel = UserDetailViewModel()
        viewModel.output = viewController
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    class func presentAsRoot() {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else {
            return
        }
        
        let viewModel = UserDetailViewModel()
        viewModel.output = viewController
        viewController.viewModel = viewModel
        
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
