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
    func loadMore()
}

protocol UsersViewModelOutput: AnyObject {
    func didGetUserList(success: Bool, err: String)
}

final class UsersViewModel {
    //MARK: - Instance properties
    weak var output: UsersViewModelOutput?
    
    private var hasMoreData = true
    private var users: [UserModel] = []
    private var since = 0
    private var size = 10
    private var isLoadingData = false
//    [UserModel(id: "ID_1", name: "User 1", avatarUrl: "", title: "STAFF"),
//                                      UserModel(id: "ID_2", name: "User 2", avatarUrl: "", title: "STAFF STAFF STAFF STAFF STAFF STAFF"),
//                                      UserModel(id: "ID_3", name: "User 3", avatarUrl: "", title: "")]
    
    //MARK: - Object lifecycle
    init() {
        isLoadingData = true
        getUser(since: since, per_page: size)
    }
    
    deinit {
        print("UsersViewModel deinit")
    }
    
    private func getUser(since: Int, per_page: Int) {
        APIGateway.shared.getUsers(since: since, per_page: per_page, completionHandler: { [weak self] userList, success in
            self?.isLoadingData = false
            if success {
                if userList.isEmpty {
                    self?.hasMoreData = false
                } else {
                    if self?.since == 0 {
                        self?.users.removeAll()
                    }
                    self?.users.append(contentsOf: userList)
                }
                
                self?.output?.didGetUserList(success: true, err: "")
            } else {
                // Show error message
                self?.output?.didGetUserList(success: false, err: "Something wrong! Please try again later.")
            }
        })
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
        return hasMoreData ? 2 : 1
    }
    
    func viewDidLoad() {
        print("UsersViewModel viewDidLoad")
    }
    
    func numberOfItems(in section: Int) -> Int {
        return section == 0 ? users.count : (hasMoreData ? 1 : 0)
    }
    
    func loadMore() {
        if !isLoadingData {
            since += size
            getUser(since: since, per_page: size)
            if since >= 300 {
                hasMoreData = false
            }
        }
    }
}
