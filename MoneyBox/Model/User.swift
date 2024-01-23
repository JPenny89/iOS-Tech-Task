//
//  User.swift
//  MoneyBox
//
//  Created by James Penny on 17/01/2024.
//

import Foundation

struct User {
    let forename: String?
    let surname: String?
}

class UserService {
    static let shared = UserService()
    var user: User?
    private init() {}
}
