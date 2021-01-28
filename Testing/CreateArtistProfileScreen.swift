//
//  CreateArtistProfileScreen.swift
//  Testing
//
//  Created by user187615 on 12/1/20.
//

import UIKit

class CreateArtistProfileScreen: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var selectCountryField: UITextField!
    @IBOutlet weak var countryDropDown: UIPickerView!
    
    
    var selectedCountry: String?
    var countries: [String] = [ ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        //countries = ["Japan","China","India"]
        print("loaded")
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        print("return countries count")
        return countries.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        print("returned countries row")
        return countries[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectCountryField.text = self.countries[row]
        self.countryDropDown.isHidden = true
        print("selected row")
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.selectCountryField {
            self.countryDropDown.isHidden = false
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
            print("editing text")
        }
        print("not editing text")
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
