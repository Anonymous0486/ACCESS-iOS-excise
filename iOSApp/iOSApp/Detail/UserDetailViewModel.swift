//
//  UserDetailViewModel.swift
//  iOSApp

//  Created by thanh nguyen trong on 09/08/2022.
//


import Foundation

protocol UserDetailViewModelInput: AnyObject {
    func viewDidLoad()
    func numberOfItems(in section: Int) -> Int
    func getItemAt(indexPath: IndexPath) -> DetailItemModel
}

protocol UserDetailViewModelOutput: AnyObject {
    func didGetUserDetail(user: UserDetailModel?, err: String)
}


final class UserDetailViewModel {
    //MARK: - Instance properties
    weak var output: UserDetailViewModelOutput?
    
    private var detailItems: [DetailItemModel] = []
    
    //MARK: - Object lifecycle
    init(with username: String) {
        getUserDetail(username: username)
    }
    
    func getUserDetail(username: String) {
        APIGateway.shared.getUserDetail(username: username) { [weak self] userDetail, success in
            if let _user = userDetail, success == true {
                self?.detailItems.append(DetailItemModel(icon: "ic_contact", title: _user.login, subTitle: _user.isAdmin ? "STAFF" : "", isHyperLink: false))
                self?.detailItems.append(DetailItemModel(icon: "ic_location", title: _user.location, subTitle: "", isHyperLink: false))
                self?.detailItems.append(DetailItemModel(icon: "ic_link", title: _user.blog, subTitle: "", isHyperLink: true))
                
                self?.output?.didGetUserDetail(user: _user, err: "")
            } else {
                // Show error message
                self?.output?.didGetUserDetail(user: nil, err: "Something wrong! Please try again later.")
            }
        }
    }
    
    deinit {
        print("UserDetailViewModel deinit")
    }
}

//MARK: - Input
extension UserDetailViewModel: UserDetailViewModelInput {
    func numberOfItems(in section: Int) -> Int {
        detailItems.count
    }
    
    func getItemAt(indexPath: IndexPath) -> DetailItemModel {
        detailItems[indexPath.row]
    }
    
    func viewDidLoad() {
        print("UserDetailViewModel viewDidLoad")
    }
}
