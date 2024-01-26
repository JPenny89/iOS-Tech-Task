//
//  FetchProductsTests.swift
//  MoneyBoxTests
//
//  Created by James Penny on 25/01/2024.
//

@testable import MoneyBox
import Networking
import XCTest

class ProductDetailViewControllerTests: XCTestCase {
    var viewController: AccountDetailsViewController!
    var dataProvider: DataProviderMock!
    var loginResponse: LoginResponse!
    
    override func setUp() {
        super.setUp()
        dataProvider = DataProviderMock()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        self.viewController = storyboard.instantiateViewController(withIdentifier: "AccountDetailsView") as? AccountDetailsViewController
        self.viewController.loadViewIfNeeded()
        let dataProvider = DataProviderMock()
        dataProvider.login(request: LoginRequest(email: "test+ios@moneyboxapp.com", password: "password")) { result in
            switch result {
            case .success(let loginResponseResult):
                self.loginResponse = loginResponseResult
            case .failure(let error):
                XCTFail("Failure returned \(error).")
            }
            dataProvider.fetchProducts() { result in
                switch result {
                case .success(let accountResponse):
                    self.viewController.product = accountResponse.productResponses?[0]
                    self.viewController.viewDidLoad()
                case .failure(let error):
                    XCTFail("Failure returned \(error).")
                }
            }
        }
        self.viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        self.viewController = nil
        dataProvider = nil
        super.tearDown()
    }
    
    func test_fetch_products() {
        let expectatedResult = expectation(description: "Waiting for result")
        dataProvider.fetchProducts() { result in
            switch result {
            case .success(let accountResponse):
                if let accountsReceived = accountResponse.accounts {
                    XCTAssertGreaterThan(accountsReceived.count, 0)
                } else {
                    XCTFail("Accounts is nil")
                }
            case .failure(let error):
                XCTFail("Failure returned \(error)")
            }
            expectatedResult.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }
    
    func test_populate_UI() {
        let productResponse = viewController.product
        XCTAssertEqual(self.viewController.accountNameLabel.text, "Stocks & Shares ISA")
        XCTAssertEqual(self.viewController.planValueLabel.text, "Total Plan Value: £\(String(productResponse?.planValue ?? 0))")
        XCTAssertEqual(self.viewController.moneyboxValueLabel.text, "Moneybox: £\(String(productResponse?.moneybox ?? 0))0")
    }
}
