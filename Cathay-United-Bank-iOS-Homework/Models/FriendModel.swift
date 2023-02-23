//
//  FriendModel.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/16.
//

import Foundation

struct FriendModel: Decodable {
    var response: [Friend]
}

struct Friend: Decodable {
    var name: String
    var status: Int
    var isTop: String
    var fid: String
    var updateDate: String
}
