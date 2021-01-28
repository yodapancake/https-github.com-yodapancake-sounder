//
//  ArtistCreateProfileScreen.swift
//  Testing
//
//  Created by user187615 on 12/4/20.
//

import CountryPicker
import UIKit

class ArtistCreateProfileScreen: SetupClass {

    var artistOrBandNameTextField: UITextField = UITextField()
    var genreTextField: UITextField = UITextField()
    var countryTextField: UITextField = UITextField()
    var postalCodeTextField: UITextField = UITextField()
    var whatAreYouTextField: UITextField = UITextField()
    
    var pickerView: UIPickerView = UIPickerView()
    
    var continueButton: UIButton = UIButton()
    var errorLabel: UILabel = UILabel()
    
    var selection = ""
    
    let genres = ["","Country", "Riddim", "Rock", "Jazz"]
    let countries = ["","United States", "Japan", "Italy", "Norway", "Israel"]
    let whatareyou = ["","Band member", "Manager", "Band lead", "Artist"]
    
    var fields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        
        artistOrBandNameTextField = createTextField(label: "Artist or band name")
        genreTextField = createTextField(label: "Genre")
        countryTextField = createTextField(label: "Country")
        postalCodeTextField = createTextField(label: "Postal code")
        whatAreYouTextField = createTextField(label: "What are you")
        
        continueButton = createContinueButton()
        errorLabel = createErrorLabel()
        
        pickerView = createPickerView()
        
        fields.append(contentsOf: [artistOrBandNameTextField, genreTextField, countryTextField, postalCodeTextField, whatAreYouTextField])
        setup()
    }
    func setup() {
        genreTextField.tintColor = .clear
        countryTextField.tintColor = .clear
        whatAreYouTextField.tintColor = .clear
        let stack = createStack(textFields: fields, view: self.view)
        stack.addArrangedSubview(continueButton)
        stack.addArrangedSubview(errorLabel)
        view.addSubview(stack)
    }
    func createPickerView() -> UIPickerView {
        let picker = UIPickerView()
        view.addSubview(picker)
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        picker.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        picker.backgroundColor = .white
        picker.isHidden = true
        return picker
    }

    func createContinueButton() -> UIButton {
        let button = UIButton()
        button.setTitle("continue", for: .normal)
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        return button
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.isHidden = false
        if textField == genreTextField {
            selection = "genre"
            textField.inputView = pickerView
        } else if textField == countryTextField {
            selection = "countries"
            textField.inputView = pickerView
        } else if textField == whatAreYouTextField {
            selection = "whatareyou"
            textField.inputView = pickerView
        }
        pickerView.reloadAllComponents()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        pickerView.selectRow(0, inComponent: 0, animated: true)
        selection = ""
        pickerView.isHidden = true
        resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == genreTextField || textField == countryTextField || textField == whatAreYouTextField {
            return false
        }
        return true
    }
    @objc func continueButtonPressed(sender: UIButton!) {
        continueButton.startAnimatingPressActions()
        let err = Utilties.validateFields(fields: fields)
        if err != nil {
            errorLabel.alpha = 1
            errorLabel.text = err
        } else {
            let nextViewController = ContinuedArtistCreateProfileScreen()
            nextViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissSelf))
            nextViewController.artistOrBandName = self.artistOrBandNameTextField.text
            nextViewController.genre = self.genreTextField.text
            nextViewController.country = self.countryTextField.text
            nextViewController.postalCode = self.postalCodeTextField.text
            nextViewController.whatAreYou = self.whatAreYouTextField.text
            let nav = UINavigationController(rootViewController: nextViewController)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }
    


}
extension ArtistCreateProfileScreen: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (selection == "genre") {
            return genres.count
        } else if (selection == "countries") {
            return countries.count
        } else if (selection == "whatareyou"){
            return whatareyou.count
        } else {
            return 0
        }
    }
}
extension ArtistCreateProfileScreen: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (selection == "genre") {
            return genres[row]
        } else if (selection == "countries") {
            return countries[row]
        } else if (selection == "whatareyou"){
            return whatareyou[row]
        } else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (selection == "genre") {
            genreTextField.text = genres[row]
        } else if (selection == "countries") {
            countryTextField.text = countries[row]
        } else if (selection == "whatareyou"){
            whatAreYouTextField.text = whatareyou[row]
        }
    }
}

