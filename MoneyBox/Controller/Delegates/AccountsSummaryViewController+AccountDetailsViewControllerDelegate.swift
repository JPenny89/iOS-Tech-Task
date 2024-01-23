//
//  AccountsSummaryViewController+AccountDetailsViewControllerDelegate.swift
//  MoneyBox
//
//  Created by James Penny on 23/01/2024.
//

import UIKit
import Networking

extension AccountsSummaryViewController: AccountDetailsViewControllerDelegate {
    
    func accountDetailsViewControllerUpdated(_ updatedAccount: ProductResponse) {
        if let index = products.firstIndex(where: { $0.id == updatedAccount.id }) {
            products[index] = updatedAccount
            print("updatedAccount = \(updatedAccount)")
        }
        fetchAccounts()
    }
}
