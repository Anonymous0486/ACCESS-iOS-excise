//
//  APIGateway+User.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 09/08/2022.
//

import Foundation
import Moya
import ObjectMapper

protocol UserRepository {
    
    func getUsers(since: Int, per_page: Int, completionHandler: @escaping ([UserModel], Bool) -> Void)
    func getUserDetail(username: String, completionHandler: @escaping (UserDetailModel?, Bool) -> Void)
}

extension APIGateway: UserRepository {
    func getUsers(since: Int, per_page: Int, completionHandler: @escaping ([UserModel], Bool) -> Void) {
        userProvider.request(.list(since: since, per_page: per_page)) { result in
            switch result {
            case .success(let response):
                print("GetUser: success statusCode=\(response.statusCode)")
                switch response.statusCode {
                case 200:
                    let jsonArray = try? response.mapJSON() as? [[String: Any]]
                    let responseModel = Mapper<UserModel>().mapArray(JSONArray: jsonArray ?? [[:]])
                    completionHandler(responseModel, true)
                default:
                    completionHandler([], false)
                }
                
            case .failure(let moyaError):
                print("failure: \(String(describing: moyaError.errorDescription))")
                completionHandler([], false)
            }
        }
    }
    

    func getUserDetail(username: String, completionHandler: @escaping (UserDetailModel?, Bool) -> Void) {
        userProvider.request(.detail(username: username)) { result in
            switch result {
            case .success(let response):
                print("GetUserDetail success statusCode=\(response.statusCode)")
                switch response.statusCode {
                case 200:
                    let json = try? response.mapJSON() as? [String: Any]
                    let responseModel = Mapper<UserDetailModel>().map(JSON: json ?? [:])
                    completionHandler(responseModel, true)
                default:
                    completionHandler(nil, false)
                }
                
            case .failure(let moyaError):
                print("failure: \(String(describing: moyaError.errorDescription))")
                completionHandler(nil, false)
            }
        }
    }
}
