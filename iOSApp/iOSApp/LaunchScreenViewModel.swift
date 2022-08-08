//
//  LaunchScreenViewModel.swift
//  iOSApp

//  Created by thanh nguyen trong on 08/08/2022.
//


import Foundation

protocol LaunchScreenViewModelInput: AnyObject {
    func viewDidLoad()
    func isLogedIn() -> Bool
}

protocol LaunchScreenViewModelOutput: AnyObject {
    
}


final class LaunchScreenViewModel {
    //MARK: - Instance properties
    weak var output: LaunchScreenViewModelOutput?
    fileprivate let defaults = UserDefaults.standard
    
    //MARK: - Object lifecycle
    init() {
        
    }
    
    deinit {
        print("LaunchScreenViewModel deinit")
    }
}

//MARK: - Input
extension LaunchScreenViewModel: LaunchScreenViewModelInput {
    func isLogedIn() -> Bool {
        if let _ = defaults.string(forKey: LocalStorageKey.access_token) {
            return true
        } else {
            return false
        }
    }
    
    func viewDidLoad() {
        print("LaunchScreenViewModel viewDidLoad")
    }
}
