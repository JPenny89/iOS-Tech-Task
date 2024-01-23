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
    let brandColour = UIColor(named: "AccentColor")
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var totalPlanValue: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAccounts()
        tableView.dataSource = self
        tableView.delegate = self
        greetingLabel.textColor = brandColour
        
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
    
    func didFetchAccounts() {
        tableView.reloadData()
    }
    
    func failedToFetchAccounts() {
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

//MARK: - Extensions

extension AccountsSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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

extension AccountsSummaryViewController: AccountDetailsViewControllerDelegate {
    
    func accountDetailsViewControllerUpdated(_ updatedAccount: ProductResponse) {
        if let index = products.firstIndex(where: { $0.id == updatedAccount.id }) {
            products[index] = updatedAccount
            print("updatedAccount = \(updatedAccount)")
        }
        fetchAccounts()
    }
}
