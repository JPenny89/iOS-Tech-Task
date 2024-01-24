//
//  AccountsSummaryViewController+UITableViewDelegate_UITableViewDataSource.swift
//  MoneyBox
//
//  Created by James Penny on 23/01/2024.
//

import UIKit

extension AccountsSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as? AccountTableViewCellController
        else {
            fatalError("AccountTableViewCellController not configured correctly.")
        }
        let account = products[indexPath.row]
        let viewModel = AccountTableViewCell(account: account.product?.friendlyName, planValue: account.planValue, moneyboxValue: account.moneybox)
        cell.planValue.text = String(format: "Plan Value: £%.2f", viewModel.planValue ?? 0.0)
        cell.accountName.text = "\(viewModel.account ?? "")"
        cell.moneyboxValue.text = String(format: "Moneybox: £%.2f", viewModel.moneyboxValue ?? 0.0)
        return cell
    }
    
    func tableView(_ accountsSummaryTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        performSegue(withIdentifier: "goToAccount", sender: product)
    }
}
