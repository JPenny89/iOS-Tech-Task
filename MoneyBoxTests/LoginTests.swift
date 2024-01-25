//
//  LoginTests.swift
//  MoneyBoxTests
//
//  Created by James Penny on 25/01/2024.
//

import XCTest
@testable import MoneyBox
@testable import Networking

class LoginViewControllerTests: XCTestCase {
    
    var viewController: LoginViewController!
    var dataProvider: DataProviderMock!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        self.viewController = storyboard.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController
        self.dataProvider = DataProviderMock()
        self.viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        self.viewController = nil
        self.dataProvider = nil
        super.tearDown()
    }
    
    func test_Login() {
        let expectatedResult = expectation(description: "Waiting for result")
        let dataProvider = DataProviderMock()
        dataProvider.login(request: LoginRequest(email: "test+ios@moneyboxapp.com", password: "password")) { result in
            switch result {
            case .success(let loginResponse):
                XCTAssertNotNil(loginResponse.session.bearerToken)
                XCTAssertEqual(loginResponse.user.firstName, "Michael")
                XCTAssertEqual(loginResponse.user.lastName, "Jordan")
                XCTAssertEqual(loginResponse.session.bearerToken, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
            case .failure(let error):
                XCTFail("Failure returned \(error)")
            }
            expectatedResult.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }
}
