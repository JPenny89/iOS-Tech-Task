//
//  AccountDetailsViewController.swift
//  MoneyBox
//
//  Created by James Penny on 17/01/2024.
//

import UIKit
import Networking

protocol AccountDetailsViewControllerDelegate: AnyObject {
    func accountDetailsViewControllerUpdated(_ updatedAccount: ProductResponse)
}

class AccountDetailsViewController: UIViewController {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyboxValueLabel: UILabel!
    @IBOutlet weak var UIView: UIView!
    
    var product: ProductResponse?
    let dataProvider = DataProvider()
    weak var delegate: AccountDetailsViewControllerDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.backgroundColor = Colour.GreyColour
        accountNameLabel.textColor = Colour.AccentColour
        
        guard let product = product else { return }
        accountNameLabel.text = product.product?.friendlyName
        if let planValue = product.planValue {
            planValueLabel.text = String(format: "Total Plan Value: £%.2f", planValue)
        }
        else {
            planValueLabel.text = "Total Plan Value: £0"
        }
        if let moneybox = product.moneybox {
            moneyboxValueLabel.text = String(format: "Moneybox: £%.2f", moneybox)
        }
        else {
            moneyboxValueLabel.text = "Moneybox: £0"
        }
    }
    
    private func addMoney(to product: ProductResponse) {
        guard let productId = product.id
        else {
            print("productId missing")
            return
        }
        dataProvider.addMoney(
            request: OneOffPaymentRequest(
                amount: 10,
                investorProductID: productId)
        ) {[weak self] result in
            switch result {
            case .success(let success):
                if let moneybox = success.moneybox {
                    self?.successfullyAdded(moneybox: moneybox)
                    self?.delegate?.accountDetailsViewControllerUpdated((self?.product)!)
                }
            case .failure(_):
                self?.failedAddingMoney()
            }
        }
    }
    
    private func successfullyAdded(moneybox: Double) {
        moneyboxValueLabel.text = String(format: "Moneybox: £%.2f", moneybox)
    }
    
    private func failedAddingMoney() {
        // handle error
    }
    
    @IBAction func increaseBalance(_ sender: UIButton) {
        guard let product = product
        else { return }
        addMoney(to: product)
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
