//
//  AccountDetailsViewController.swift
//  MoneyBox
//
//  Created by James Penny on 17/01/2024.
//

import UIKit
import Networking

class AccountDetailsViewController: UIViewController {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyboxValueLabel: UILabel!
    
    var product: ProductResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func increaseBalance(_ sender: UIButton) {
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
