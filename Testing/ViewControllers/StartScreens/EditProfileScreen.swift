//
//  EditProfileScreen.swift
//  Testing
//
//  Created by user187615 on 12/28/20.
//

import UIKit

class EditProfileScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    
    
}

class EditProfileScreenTextFields: UITextField {
    var field: UITextField
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    convenience init(field: String) {
        self.init(frame: .zero)
        self.field = field.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
