//
//  SetupClass.swift
//  Testing
//
//  Created by user187615 on 12/12/20.
//

import UIKit
import Foundation

class SetupClass: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemIndigo
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        //errormessage.alpha = 0
        view.endEditing(true)
    }
    func createErrorLabel() -> UILabel {
        let label = UILabel()
        label.text = ""
        label.textAlignment = NSTextAlignment.center;
        label.alpha = 0
        label.contentMode = .scaleToFill
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: 250).isActive = true
        label.adjustsFontSizeToFitWidth = true
        label.layer.borderWidth = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func createStack(textFields: [UITextField], view: UIView) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        for tf in textFields {
            stack.addArrangedSubview(tf)
        }
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return stack
    }
    func createTextField(label: String) -> UITextField {
        let tf = UITextField()
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tf.widthAnchor.constraint(equalToConstant: 300),
            tf.heightAnchor.constraint(equalToConstant: 45)
        ])
        tf.placeholder = label
        tf.layer.cornerRadius = 5.0
        tf.layer.borderWidth = 1
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 40))
        tf.leftViewMode = UITextField.ViewMode.always
        tf.backgroundColor = .white
        let placeholder = tf.attributedPlaceholder!.mutableCopy() as! NSMutableAttributedString
        placeholder.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray ], range: NSMakeRange(0, tf.attributedPlaceholder!.length))
        tf.attributedPlaceholder = placeholder
        return tf
    }

}
extension UIButton {
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)
    }
    
}
