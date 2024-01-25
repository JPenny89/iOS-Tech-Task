//
//  DataProviderMock.swift
//  MoneyBoxTests
//
//  Created by James Penny on 25/01/2024.
//

import Foundation
@testable import Networking

class DataProviderMock: DataProviderLogic {
    func login(request: Networking.LoginRequest, completion: @escaping ((Result<Networking.LoginResponse, Error>) -> Void)) {
        StubData.read(file: "LoginSucceed", callback: completion)
    }
    
    func fetchProducts(completion: @escaping ((Result<Networking.AccountResponse, Error>) -> Void)) {
        StubData.read(file: "Accounts", callback: completion)
    }
    
    func addMoney(request: Networking.OneOffPaymentRequest, completion: @escaping ((Result<Networking.OneOffPaymentResponse, Error>) -> Void)) {
        StubData.read(file: "Added10Pounds", callback: completion)
    }
}
