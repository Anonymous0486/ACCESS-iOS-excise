//
//  UserDetailModel.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 10/08/2022.
//

import UIKit
import ObjectMapper

public struct UserDetailModel : Mappable {
    var avatarUrl: String = ""
    var name: String = ""
    var bio: String = ""
    var login: String = ""
    var isAdmin: Bool = false
    var location: String = ""
    var blog: String = ""

    
    init() {}
    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        avatarUrl <- map["avatar_url"]
        name <- map["name"]
        bio <- map["bio"]
        login <- map["login"]
        isAdmin <- map["site_admin"]
        location <- map["location"]
        blog <- map["blog"]
    }
}
