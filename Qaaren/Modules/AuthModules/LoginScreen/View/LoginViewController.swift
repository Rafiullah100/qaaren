//
//  LoginViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit
import GoogleSignIn
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
    private var isLoginButtonTapped = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        emailTextField.textAlignment = Helper.isRTL() ? .right : .left
        passwordTextField.textAlignment = Helper.isRTL() ? .right : .left
        emailTextField.text = "zas@gmail.com"
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
            viewModel.authenticateUser()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    @IBAction func googleSigninBtn(_ sender: Any) {
        let clientID = Constants.clientID ?? ""
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard error == nil else {
                return
            }
            if let result = result,
               let email = result.user.profile?.email,
               let imageURL = result.user.profile?.imageURL(withDimension: 120)?.absoluteString {
                   self?.viewModel.googleSignin(email: email)
            }
        }
    }
    
    private func bindResult(){
        viewModel.errorMessage.bind { [weak self] errorMessage in
            guard let self = self, let errorMessage = errorMessage else {return}
            self.showAlert(message: errorMessage)
        }
        
        viewModel.isUserExist.bind { [weak self] isExist in
            guard let self = self else{return}
            self.stopAnimation()
            if isExist == true{
                Switcher.gotoHomeVC(delegate: self)
            }
        }
        
        viewModel.googleLogin.bind { [unowned self] response in
            showAlert(message: response?.message ?? "")
        }
    }
    
    @IBAction func skipLoginButton(_ sender: Any) {
        Switcher.gotoHomeVC(delegate: self)
    }
}


