//
//  UsersViewModel.swift
//  iOSApp

//  Created by thanh nguyen trong on 08/08/2022.
//


import UIKit

protocol UsersViewModelInput: AnyObject {
    var cellHeight: CGFloat { get }
    
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func getItemAt(indexPath: IndexPath) -> UserModel
}

protocol UsersViewModelOutput: AnyObject {
    
}

final class UsersViewModel {
    //MARK: - Instance properties
    weak var output: UsersViewModelOutput?
    
    private var users: [UserModel] = [UserModel(id: "ID_1", name: "User 1", avatarUrl: "", title: "STAFF"),
                                      UserModel(id: "ID_2", name: "User 2", avatarUrl: "", title: "STAFF STAFF STAFF STAFF STAFF STAFF"),
                                      UserModel(id: "ID_3", name: "User 3", avatarUrl: "", title: "")]
    
    //MARK: - Object lifecycle
    init() {
        
    }
    
    deinit {
        print("UsersViewModel deinit")
    }
}

//MARK: - Input
extension UsersViewModel: UsersViewModelInput {
    var cellHeight: CGFloat {
        return CGFloat(82)
    }
    
    func getItemAt(indexPath: IndexPath) -> UserModel {
        users[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func viewDidLoad() {
        print("UsersViewModel viewDidLoad")
    }
    
    func numberOfItems(in section: Int) -> Int {
        return users.count
    }
}
