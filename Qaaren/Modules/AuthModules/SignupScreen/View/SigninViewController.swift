//
//  SigninViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit

class SignupViewController: BaseViewController {

    @IBOutlet weak var secureConfirmIcon: UIImageView!
    @IBOutlet weak var securePasswordIcon: UIImageView!
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
   
    private var viewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        viewModel.signup.bind { [unowned self] signup in
            self.stopAnimation()
            if signup?.success == true{
                Switcher.gotoOtpScreen(delegate: self, email: emailTextField.text ?? "")
            }
            else{
                showAlert(message: signup?.message ?? "")
            }
        }
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
    
    @IBAction func passwordSecureButtonAction(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        securePasswordIcon.image = passwordTextField.isSecureTextEntry == true ? UIImage(named: "hide-icon") : UIImage(named: "eye")
    }
    
    @IBAction func confirmSecureButtonAction(_ sender: Any) {
        confirmTextField.isSecureTextEntry.toggle()
        secureConfirmIcon.image = confirmTextField.isSecureTextEntry == true ? UIImage(named: "hide-icon") : UIImage(named: "eye")
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        let signup = SignupInputModel(name: nameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", confirm: confirmTextField.text ?? "")
        let validationResponse = viewModel.isFormValid(user: signup)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.signupUser()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    @IBAction func signinBtn(_ sender: Any) {
         navigationController?.popViewController(animated: true)
     }
}
