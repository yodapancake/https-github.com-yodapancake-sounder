//
//  SetupNavigationController.swift
//  Testing
//
//  Created by user187615 on 12/7/20.
//

import UIKit

class SetupNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = CreateProfile()
        
        viewControllers = [vc1]
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
