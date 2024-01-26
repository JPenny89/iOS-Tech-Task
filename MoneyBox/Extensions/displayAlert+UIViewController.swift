//
//  displayAlert+UIViewController.swift
//  MoneyBox
//
//  Created by James Penny on 25/01/2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let accept = UIAlertAction(title: "OK", style: .default)
        alert.addAction(accept)
        present(alert, animated: true)
    }
}
