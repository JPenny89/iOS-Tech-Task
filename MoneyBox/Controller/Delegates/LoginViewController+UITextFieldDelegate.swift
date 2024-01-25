//
//  LoginViewController+UITextFieldDelegate.swift
//  MoneyBox
//
//  Created by James Penny on 24/01/2024.
//

import UIKit

extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
