//
//  LoginViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var secureIcon: UIImageView!
    @IBOutlet weak var signupLabel: UIButton!
    @IBOutlet weak var noAccountLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var googleLabel: UILabel!
    @IBOutlet weak var fbLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var skipLabel: UIButton!
    
    private var viewModel: LoginViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        emailTextField.text = "ali@gmail.com"
        passwordTextField.text = "123456"
        updateUI()
        initVM()
        bindResult()
    }
    
    private func initVM(){
        viewModel = LoginViewModel()
    }
    
    private func updateUI(){
        skipLabel.setTitle(LocalizationKeys.skipLogin.rawValue.localizeString(), for: .normal)
        emailAddress.text = LocalizationKeys.emailAddress.rawValue.localizeString()
        signupLabel.setTitle(LocalizationKeys.signup.rawValue.localizeString(), for: .normal)
        emailTextField.placeholder = LocalizationKeys.emailAddress.rawValue.localizeString()
        passwordTextField.placeholder = LocalizationKeys.password.rawValue.localizeString()
        passwordLabel.text = LocalizationKeys.password.rawValue.localizeString()
        fbLabel.text = LocalizationKeys.facebook.rawValue.localizeString()
        googleLabel.text = LocalizationKeys.google.rawValue.localizeString()
        orLabel.text = LocalizationKeys.orSignin.rawValue.localizeString()
        noAccountLabel.text = LocalizationKeys.noAccount.rawValue.localizeString()
        signinButton.setTitle(LocalizationKeys.signin.rawValue.localizeString(), for: .normal)
    }
    
    @IBAction func secureTextButtonAction(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        secureIcon.image = passwordTextField.isSecureTextEntry == true ? UIImage(named: "hide-icon") : UIImage(named: "eye")
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        let login = LoginInputModel(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        let validationResponse = viewModel.isFormValid(user: login)
        if validationResponse.isValid {
            self.animateSpinner()
            viewModel.loginUser()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    private func bindResult(){
        viewModel.bindResultToView = { [unowned self] in
            stopAnimation()
            if viewModel.login?.success == true && viewModel.login != nil{
                Switcher.gotoHomeVC(delegate: self)
            }
            else{
                showAlert(message: Constants.errorMessage)
            }
        }
    }
    
    @IBAction func skipLoginButton(_ sender: Any) {
        Switcher.gotoHomeVC(delegate: self)
    }
}


