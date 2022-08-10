//
//  APIGateway.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 09/08/2022.
//

import Foundation
import Moya

@objc public final class APIGateway: NSObject {
    
    // MARK: - PROPERTIES
    public static let shared = APIGateway()
    
    // MARK: - Provider
    
    // User
    lazy var userProvider = MoyaProvider<UserService>()

    
    // MARK: - METHODS
    public override init() {
        super.init()
    }
    
    deinit {}
    
}

