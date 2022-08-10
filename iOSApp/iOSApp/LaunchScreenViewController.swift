//
//  LaunchScreenViewController.swift
//  iOSApp

//  Created by thanh nguyen trong on 08/08/2022.
//


import UIKit

class LaunchScreenViewController: UIViewController {

    //MARK:- IBOutlets
    
    //MARK: - Constants
    
    //MARK:- Properties / Variables
    fileprivate var viewModel: LaunchScreenViewModelInput?

    //MARK: Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let isLoggedIn = viewModel?.isLogedIn(), isLoggedIn == true {
            if let vc = UsersViewController.createViewController() {
                let navi = UINavigationController(rootViewController: vc)
                UIWindow.key?.rootViewController = navi
            }
        } else {
            LoginViewController.presentAsRoot()
        }
    }
}

extension LaunchScreenViewController: LaunchScreenViewModelOutput {
    
}

extension LaunchScreenViewController {
    class func createViewController() -> LaunchScreenViewController? {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreenViewController") as? LaunchScreenViewController else {
            return nil
        }
        
        let viewModel = LaunchScreenViewModel()
        viewModel.output = viewController
        viewController.viewModel = viewModel
        
        return viewController
    }
}
