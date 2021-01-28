//
//  SettingsSections.swift
//  Testing
//
//  Created by user187615 on 12/26/20.
//
import UIKit

enum SettingsSections: Int, CaseIterable, CustomStringConvertible {
    case Account
    case Other
    var description: String {
        switch self {
        case .Account: return "Account"
        case .Other: return "Other"
        }
    }

}
enum AccountOptions: Int, CaseIterable, CustomStringConvertible {
    case editProfile
    case changePassword
    case email
    
    var description: String {
        switch self {
        case .editProfile: return "Edit Profile"
        case .changePassword: return "Change Password"
        case .email: return "Email"
        }
    }

}
enum OtherOptions: Int, CaseIterable, CustomStringConvertible {
    case notifications
    case logOut
    var description: String {
        switch self {
        case .notifications: return "Notifications"
        case .logOut: return "Log Out"
        }
    }
}

enum TargetVC: Int, CaseIterable {
    case editProfile
    case changePassword
    case email
    case notifications
    case logOut
    var targetVC: UIViewController {
        switch self {
        case .editProfile: return EditProfileScreen()
        case .changePassword: return UIViewController()
        case .email: return UIViewController()
        case .notifications: return UIViewController()
        case .logOut: return UIViewController()
        }
    }
}
