//
//  UserDetailViewModel.swift
//  iOSApp

//  Created by thanh nguyen trong on 09/08/2022.
//


import Foundation

protocol UserDetailViewModelInput: class {
    func viewDidLoad()
}

protocol UserDetailViewModelOutput: class {
    
}


final class UserDetailViewModel {
    //MARK: - Instance properties
    weak var output: UserDetailViewModelOutput?
    
    //MARK: - Object lifecycle
    init() {
        
    }
    
    deinit {
        print("UserDetailViewModel deinit")
    }
}

//MARK: - Input
extension UserDetailViewModel: UserDetailViewModelInput {
    func viewDidLoad() {
        print("UserDetailViewModel viewDidLoad")
    }
}
