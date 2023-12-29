//
//  LoginViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var secureIcon: UIImageView!
    @IBOutlet weak var signupLabel: UIButton!
    @IBOutlet weak var noAccountLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var googleLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var skipLabel: UIButton!
    @IBOutlet weak var appleSigninView: UIView!
    
    private var viewModel: LoginViewModel!
    private var isLoginButtonTapped = false
    private let appleSignInButton = ASAuthorizationAppleIDButton()

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
        googleLabel.text = LocalizationKeys.google.rawValue.localizeString()
        orLabel.text = LocalizationKeys.orSignin.rawValue.localizeString()
        noAccountLabel.text = LocalizationKeys.noAccount.rawValue.localizeString()
        signinButton.setTitle(LocalizationKeys.signin.rawValue.localizeString(), for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleSigninView.addSubview(appleSignInButton)
        appleSignInButton.frame = CGRect(x: 0, y: 0, width: appleSigninView.frame.width, height: appleSigninView.frame.height)
        appleSignInButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
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
               let name = result.user.profile?.name
               /*,let imageURL = result.user.profile?.imageURL(withDimension: 120)?.absoluteString*/ {
                self?.animateSpinner()
                   self?.viewModel.googleSignin(email: email, name: name)
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
    }
    
    @IBAction func skipLoginButton(_ sender: Any) {
        Switcher.gotoHomeVC(delegate: self)
    }
}


extension  LoginViewController: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
//            let email = credential.email
//            let name = credential.fullName?.givenName
//            guard (email != nil) else {
//                self.showAlert(message: "Set apple account first!")
//                return
//            }
            if let appleUser = appleUser(credentials: credential) {
                do {
                    let appleUserData = try JSONEncoder().encode(appleUser)
                    UserDefaults.standard.set(appleUserData, forKey: credential.user)
                } catch {
                    print("Error encoding AppleUser: \(error)")
                }
            }
            self.animateSpinner()
//            viewModel.appleLogin(email: email ?? "", name: name ?? "")
        default:
            print("...")
        }
    }
}

extension  LoginViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
}

