//
//  AccountTableViewCellController.swift
//  MoneyBox
//
//  Created by James Penny on 17/01/2024.
//

import UIKit
import Networking

class AccountTableViewCellController: UITableViewCell {
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var planValue: UILabel!
    @IBOutlet weak var moneyboxValue: UILabel!
    
    override func awakeFromNib() {
        accountName.textColor = Colour.AccentColour
        layer.cornerRadius = 20
        layer.backgroundColor = Colour.GreyColour?.cgColor
    }
}
