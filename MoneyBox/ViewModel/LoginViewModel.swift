//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by James Penny on 24/01/2024.
//

//import UIKit
//import Networking
//
//class LoginViewModel: ObservableObject {
//    
//    
//    private var dataProvider: DataProviderLogic
//    
//    
//    init(dataProvider: DataProviderLogic) {
//        self.dataProvider = dataProvider
//    }
//    
//    let loginViewContoller = LoginViewController()
//    
//    func login() {
//
//        guard let email = loginViewContoller.emailTextField.text,
//              !email.isEmpty else {
//            //            display an error alert
//            return
//        }
//        guard let password = loginViewContoller.passwordTextField.text,
//              !password.isEmpty else {
//            //            display an error alert
//            return
//        }
//        
//        let dataProvider = DataProvider()
//        dataProvider.login(request: LoginRequest(email: email, password: password)) { [weak self] result in
//            guard let response = self else { return }
//            switch result {
//            case .success(let success):
//                let user = success.user
//                let session = success.session
//                Authentication.token = session.bearerToken
//                UserService.shared.user = User(forename: user.firstName, surname: user.lastName)
//                let destination = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "AccountsSummaryView") as! AccountsSummaryViewController
//                let navigationVC = UINavigationController(rootViewController: destination)
//                if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
//                    DispatchQueue.main.async {
//                        window.rootViewController = navigationVC
//                    }
//                }
//            case .failure(let failure):
//                let errorMessage = failure.localizedDescription
//                DispatchQueue.main.async {
//                    //            display an error alert
//                }
//            }
//        }
//    }
//    
//}
