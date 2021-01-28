//
//  AppDelegate.swift
//  Testing
//
//  Created by user187615 on 12/1/20.
//
import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
//        window = UIWindow(frame: UIScreen.main.bounds)
//        //UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
//        //let transitionCoordinator = TransitionCoordinator()
//
//        let userLoginStatus = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
//
//        let setupStoryBoard: UIStoryboard = UIStoryboard(name: "Setup", bundle: nil)
//        let homeStoryBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
//
//        if(userLoginStatus) {
//            let nextViewController = homeStoryBoard.instantiateViewController(withIdentifier: "HomeScreen") as! HomeScreen
//            window!.rootViewController = nextViewController
//            window?.makeKeyAndVisible()
//            return true
//        }
//        let nextViewController = setupStoryBoard.instantiateViewController(withIdentifier: "CreateProfile") as! CreateProfile
//        window!.rootViewController = nextViewController
//        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

