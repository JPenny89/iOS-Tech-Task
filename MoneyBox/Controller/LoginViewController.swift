//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Networking

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.backgroundColor = Colour.GreyColour
        passwordTextField.backgroundColor = Colour.GreyColour
        emailTextField.accessibilityLabel = "hello I am an email field"
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
              !email.isEmpty else {
            displayAlert(title: "Invalid Email", message: "Email field cannot be empty")
            return
        }
        guard let password = passwordTextField.text,
              !password.isEmpty else {
            displayAlert(title: "Invalid Password", message: "Password field cannot be empty")
            return
        }
        
        let dataProvider = DataProvider()
        dataProvider.login(request: LoginRequest(email: email, password: password)) { [weak self] result in
            guard let response = self else { return }
            switch result {
            case .success(let success):
                let user = success.user
                let session = success.session
                Authentication.token = session.bearerToken
                UserService.shared.user = User(forename: user.firstName, surname: user.lastName)
                let destination = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "AccountsSummaryView") as! AccountsSummaryViewController
                let navigationVC = UINavigationController(rootViewController: destination)
                if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                    DispatchQueue.main.async {
                        window.rootViewController = navigationVC
                    }
                }
            case .failure(let failure):
                let reasonForFailre = failure.localizedDescription
                DispatchQueue.main.async {
                    response.displayAlert(title: "Login Failed", message: "\(reasonForFailre)")
                }
            }
        }
    }
}
