//
//  Utilities.swift
//  Testing
//
//  Created by user187615 on 12/3/20.
//

import Foundation
import UIKit

class Utilties {
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    static func validateFields(fields: [UITextField]) -> String? {
        for field in fields {
            if field.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please fill in all fields"
            }
        }
        return nil
    }
    static func validatePasswords(passwordTextField: UITextField, passwordRepTextField: UITextField) -> String? {
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedRepPassword = passwordRepTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilties.isPasswordValid(cleanedPassword) == false {
            return "Please make password more secure"
        }
        if cleanedRepPassword != cleanedPassword {
            return("passwords are not the same")
        }
        return nil
    }

}


