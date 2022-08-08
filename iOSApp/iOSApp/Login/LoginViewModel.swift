//
//  LoginViewModel.swift
//  iOSApp

//  Created by thanh nguyen trong on 08/08/2022.
//


import Foundation

protocol LoginViewModelInput: AnyObject {
    func viewDidLoad()
}

protocol LoginViewModelOutput: AnyObject {
    
}


final class LoginViewModel {
    //MARK: - Instance properties
    weak var output: LoginViewModelOutput?
    
    //MARK: - Object lifecycle
    init() {
        
    }
    
    deinit {
        print("LoginViewModel deinit")
    }
}

//MARK: - Input
extension LoginViewModel: LoginViewModelInput {
    func viewDidLoad() {
        print("LoginViewModel viewDidLoad")
    }
}
