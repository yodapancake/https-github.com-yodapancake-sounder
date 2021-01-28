//
//  TabBarController.swift
//  Testing
//
//  Created by user187615 on 12/6/20.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //let accountScreen = AccountScreen()
        //accountScreen.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Settings"), style: .plain, target: self, action: #selector(settingsButtonPressed))

        let navcon1 = generateNavCon(vc: HomeScreen(), title: "Explore", image: #imageLiteral(resourceName: "Explore icon"))
        let navcon2 = generateNavCon(vc: FavoritedScreen(), title: "Favorited", image: #imageLiteral(resourceName: "Favorited icon"))
        let navcon3 = generateNavCon(vc: BookedScreen(), title: "Booked", image: #imageLiteral(resourceName: "Bookings icon"))
        let navcon4 = generateNavCon(vc: MessagesScreen(), title: "Messages", image: #imageLiteral(resourceName: "Messages icon"))
        let navcon5 = generateNavCon(vc: AccountScreen(), title: "Account", image: #imageLiteral(resourceName: "Account icon"))
        
        //UINavigationBar.appearance().prefersLargeTitles = true
        let tabBarList = [navcon1, navcon2, navcon3, navcon4, navcon5]
        viewControllers = tabBarList
    }
    
    private func generateNavCon(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        //navController.navigationBar.isHidden = true
        navController.tabBarItem.image = image
        return navController
    }

}
