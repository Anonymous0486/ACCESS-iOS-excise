//
//  UserModel.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 08/08/2022.
//

import UIKit
import ObjectMapper

public struct UserModel : Mappable {
    var name: String = ""
    var avatarUrl: String = ""
    var isAdmin: Bool = false
    
    init() {}
    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        isAdmin <- map["site_admin"]
        name <- map["login"]
        avatarUrl <- map["avatar_url"]
    }
}
