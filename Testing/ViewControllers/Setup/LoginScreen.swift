//
//  LoginScreen.swift
//  Testing
//
//  Created by user187615 on 12/3/20.
//

import Firebase
import FirebaseAuth
import SwiftUI
import UIKit

class LoginScreen: SetupClass {

    var emailTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    var logInButton: UIButton = UIButton()
    var errorMessage: UILabel = UILabel()
    
    var fields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        emailTextField = createTextField(label: "Email")
        passwordTextField = createTextField(label: "Password")
        logInButton = createLogInButton()
        errorMessage = createErrorLabel()
        fields.append(contentsOf: [emailTextField, passwordTextField])
        setup()
    }
    func setup() {
        passwordTextField.isSecureTextEntry = true
        let stack = createStack(textFields: fields, view: self.view)
        stack.addArrangedSubview(logInButton)
        stack.addArrangedSubview(errorMessage)
        view.addSubview(stack)
    }
    func createLogInButton() -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        return button
    }
    @objc func logInButtonPressed(sender: UIButton!) {
        logInButton.startAnimatingPressActions()
        let err = Utilties.validateFields(fields: fields)
        if err != nil {
            errorMessage.text = err
            errorMessage.alpha = 1
        } else {
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { [weak self] (authResult, error) in
                guard let strongSelf = self else { return }
                if error != nil {
                    strongSelf.errorMessage.text = error!.localizedDescription
                    strongSelf.errorMessage.alpha = 1
                } else {
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    
                    let nextVC = TabBarController() as UITabBarController
                    nextVC.modalTransitionStyle = .coverVertical
                    nextVC.modalPresentationStyle = .fullScreen
                    strongSelf.present(nextVC, animated:true, completion:nil)
                }
            }
        }
    }

}
