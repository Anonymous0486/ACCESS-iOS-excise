//
//  UserResponse.swift
//  iOSApp
//
//  Created by thanh nguyen trong on 10/08/2022.
//

import Foundation
import ObjectMapper
import SwiftyJSON

public struct UserResponse<Data: Mappable>: Mappable {
    public var data: [Data]?
    
    init() {}
    public init?(map: Map) {}

    mutating public func mapping(map: Map) {
        data <- map["data"]
    }
}
