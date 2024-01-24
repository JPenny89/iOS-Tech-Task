//
//  AccountsSummaryViewController.swift
//  MoneyBox
//
//  Created by James Penny on 17/01/2024.
//

import UIKit
import Networking

class AccountsSummaryViewController: UIViewController {
    
    var products: [ProductResponse] = []
    let dataProvider = DataProvider()
    var accounts: [Account] = []
    var planValue: Double?
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var totalPlanValue: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAccounts()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.layer.cornerRadius = 10
//        tableView.layer.shadowColor = CGColor.init(red: 0, green: 0, blue: 100, alpha: 1)
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = CGColor.init(red: 0.343, green: 0.750, blue: 0.710, alpha: 1)
        greetingLabel.textColor = Colour.AccentColour
//        view.backgroundColor = Colour.GreyColour
        
    }
    
    func fetchAccounts() {
        dataProvider.fetchProducts { [weak self] result in
            switch result {
            case .success(let success):
                self?.accounts = success.accounts ?? []
                self?.products = success.productResponses ?? []
                self?.planValue = success.totalPlanValue
                self?.greetingLabel.text = "Hello, \(UserService.shared.user?.forename ?? "")!"
                let formattedTotalPlanValue = String(format: "Total Plan Value: £%.2f", self?.planValue ?? 0.0)
                self?.totalPlanValue.text = formattedTotalPlanValue
                self?.didFetchAccounts()
                
            case .failure(_):
                self?.failedToFetchAccounts()
            }
        }
    }
    
    //MARK: - Do these need to go into an Extension?
    
    private func didFetchAccounts() {
        tableView.reloadData()
    }
    
    private func failedToFetchAccounts() {
        // handle error
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAccount",
           let destinationVC = segue.destination as? AccountDetailsViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow {
            destinationVC.product = products[selectedIndexPath.row]
            destinationVC.delegate = self
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        let destination = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        let navigationVC = UINavigationController(rootViewController: destination)
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            DispatchQueue.main.async {
                window.rootViewController = navigationVC
            }
        }
    }
}

