//
//  ContinuedArtistCreateProfileScreen.swift
//  Testing
//
//  Created by user187615 on 12/4/20.
//

import Firebase
import UIKit

class ContinuedArtistCreateProfileScreen: SetupClass {
    
    var artistOrBandName: String?
    var genre: String?
    var country: String?
    var postalCode: String?
    var whatAreYou: String?
    
    var firstNameTextField: UITextField = UITextField()
    var lastNameTextField: UITextField  = UITextField()
    var emailTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    var passwordRepTextField: UITextField = UITextField()
    
    var createProfileButton: UIButton = UIButton()
    var errorMessage: UILabel = UILabel()
    
    var fields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField = createTextField(label: "First name")
        lastNameTextField = createTextField(label: "Last name")
        emailTextField = createTextField(label: "Email")
        passwordTextField = createTextField(label: "Password")
        passwordRepTextField = createTextField(label: "Password repeated")
        createProfileButton = createCreateProfileButton()
        errorMessage = createErrorLabel()
        fields.append(contentsOf: [firstNameTextField,lastNameTextField,emailTextField,passwordTextField,passwordRepTextField])
        setup()
    }
    func setup() {
        passwordTextField.isSecureTextEntry = true
        passwordRepTextField.isSecureTextEntry = true
        let stack = createStack(textFields: [firstNameTextField,lastNameTextField,emailTextField,passwordTextField,passwordRepTextField], view: self.view)
        stack.addArrangedSubview(createProfileButton)
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
                    db.collection("artistsg").addDocument(data: ["first_name": self.firstNameTextField.text!, "last_name": self.lastNameTextField.text!, "uid": Auth.auth().currentUser!.uid, "country": self.country!, "postal_code": self.postalCode!, "artist_or_band_name": self.artistOrBandName!, "what_are_you": self.whatAreYou!, "genre": self.genre!]) { (error) in
                        if error != nil {
                            print("error in db")
                        }
                    }
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    let nextVC = TabBarController() as UIViewController
                    nextVC.modalTransitionStyle = .coverVertical
                    nextVC.modalPresentationStyle = .fullScreen
                    self.present(nextVC, animated:true, completion:nil)
                }
            }

        }
        
    }

}


