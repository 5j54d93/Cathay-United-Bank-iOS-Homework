//
//  UserModel.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/16.
//

import Foundation

struct UserModel: Decodable {
    var response: [User]
}

struct User: Decodable {
    var name: String
    var kokoid: String?
}
