//
//  UserService.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 09/08/2022.
//

import Foundation
import Moya

enum UserService {
    case list(since: Int, per_page: Int)
    case detail(username: String)
}

extension UserService: TargetType {
    var sampleData: Data {
        return Data()
    }
    
    var urlParameters: [String : Any]? {
        return [:]
    }

    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var path: String {
        switch self {
        case .list:
            return "/users"
        case .detail(let username):
            return "/users/\(username)"

        }
    }

    var method: Moya.Method {
        switch self {
        case .list, .detail:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .list(let since, let per_page):
            let params: Dictionary = [
                "since" : since,
                "per_page" : per_page
            ] as [String: Any]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .detail:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return makeHeader()
    }
    
    private func makeHeader(_ params: [String: String]? = nil) -> [String: String] {
        var headers: [String: String] = [
            "Accept": "application/vnd.github+json"
        ]
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: LocalStorageKey.access_token), !token.isEmpty {
            headers["Authorization"] = "token \(token)"
        }
        
        return headers
    }
}
