//
//  SigninViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var alreadyLabel: UILabel!
    @IBOutlet weak var singupButton: UIButton!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI(){
        alreadyLabel.text = LocalizationKeys.alreadyAccount.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.name.rawValue.localizeString()
        emailLabel.text = LocalizationKeys.emailAddress.rawValue.localizeString()
        passwordLabel.text = LocalizationKeys.password.rawValue.localizeString()
        confirmLabel.text = LocalizationKeys.confirmPassword.rawValue.localizeString()
        nameTextField.placeholder = LocalizationKeys.name.rawValue.localizeString()
        emailTextField.placeholder = LocalizationKeys.emailAddress.rawValue.localizeString()
        passwordTextField.placeholder = LocalizationKeys.password.rawValue.localizeString()
        confirmTextField.placeholder = LocalizationKeys.password.rawValue.localizeString()
        loginButton.setTitle(LocalizationKeys.signin.rawValue.localizeString(), for: .normal)
        singupButton.setTitle(LocalizationKeys.signup.rawValue.localizeString(), for: .normal)
    }
    
     @IBAction func signinBtn(_ sender: Any) {
         navigationController?.popViewController(animated: true)
     }

}
