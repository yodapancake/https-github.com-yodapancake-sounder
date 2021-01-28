//
//  CreateProfile.swift
//  Testing
//
//  Created by user187615 on 12/2/20.
//

 
import Firebase
import FirebaseAuth
import SwiftUI
import UIKit

class CreateProfile: SetupClass {

    var firstNameTextField: UITextField = UITextField()
    var lastNameTextField: UITextField  = UITextField()
    var emailTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    var passwordRepTextField: UITextField = UITextField()
    
    var createProfileButton: UIButton = UIButton()
    var errorMessage: UILabel = UILabel()
    var logIn: UIButton = UIButton()
    var artistSignUp: UIButton = UIButton()
    
    var fields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        

        firstNameTextField = createTextField(label: "First name")
        lastNameTextField = createTextField(label: "Last name")
        emailTextField = createTextField(label: "Email")
        passwordTextField = createTextField(label: "Password")
        passwordRepTextField = createTextField(label: "Password repeated")
        
        createProfileButton = createCreateProfileButton()
        logIn = createLogInButton()
        artistSignUp = createArtistSignUpButton()
        errorMessage = createErrorLabel()
        
        fields.append(contentsOf: [firstNameTextField,lastNameTextField,emailTextField,passwordTextField,passwordRepTextField])

        setup()
    }
    func setup() {
        passwordTextField.textContentType = .newPassword
        passwordRepTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        passwordRepTextField.isSecureTextEntry = true
        let stack = createStack(textFields: [firstNameTextField,lastNameTextField,emailTextField,passwordTextField,passwordRepTextField], view: self.view)
        stack.addArrangedSubview(createProfileButton)
        stack.addArrangedSubview(logIn)
        stack.addArrangedSubview(artistSignUp)
        stack.addArrangedSubview(errorMessage)
        view.addSubview(stack)
    }
    func createCreateProfileButton() -> UIButton {
        let button = UIButton()
        button.setTitle("create profile", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(createProfileButtonPresssed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        return button
    }
    func createLogInButton() -> UIButton {
        let login = UIButton()
        login.setTitle("Log in", for: .normal)
        login.addTarget(self, action: #selector(logInClicked), for: .touchUpInside)
        return login
    }
    func createArtistSignUpButton() -> UIButton {
        let artistsignup = UIButton()
        artistsignup.setTitle("Artist sign up", for: .normal)
        artistsignup.addTarget(self, action: #selector(artistSignUpButtonPressed), for: .touchUpInside)
        return artistsignup
    }
    
    @objc func logInClicked() {
        let loginScreenVC = LoginScreen() as UIViewController
        loginScreenVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissSelf))
        let nav = UINavigationController(rootViewController: loginScreenVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    @objc func createProfileButtonPresssed(sender: UIButton!){
        createProfileButton.startAnimatingPressActions()
        var error = Utilties.validateFields(fields: fields)
        if error == nil {
            error = Utilties.validatePasswords(passwordTextField: passwordTextField, passwordRepTextField: passwordRepTextField)
        }
        if error != nil {
            errorMessage.alpha = 1
            errorMessage.text = error
        } else {
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (result, err) in
                if err != nil {
                    self.errorMessage.alpha = 1
                    self.errorMessage.text = err!.localizedDescription
                }
                else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["first_name": self.firstNameTextField.text!, "last_name": self.lastNameTextField.text!, "uid": Auth.auth().currentUser!.uid]) { (error) in
                        if error != nil {
                            print("error in db")
                        }
                    }
                    
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    
                    let nextVC = TabBarController() as UITabBarController
                    nextVC.modalTransitionStyle = .coverVertical
                    nextVC.modalPresentationStyle = .fullScreen
                    self.present(nextVC, animated:true, completion:nil)
                }
            }

        }
        
    }
    @objc func artistSignUpButtonPressed() {
        let nextVC = ArtistCreateProfileScreen() as UIViewController
        nextVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissSelf))
        let nav = UINavigationController(rootViewController: nextVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

}

