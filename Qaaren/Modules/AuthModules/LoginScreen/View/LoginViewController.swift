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
//        emailTextField.text = "rafiullah@gmail.com"
//        passwordTextField.text = "123"
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
            if let appleUser = AppleUserData(credentials: credential),
               let data = try? JSONEncoder().encode(appleUser) {
                do {
                    UserDefaults.standard.appleUserData = data
                    let email = credential.email ?? ""
                    let name = (credential.fullName?.givenName ?? "") + (credential.fullName?.familyName ?? "")
                    self.viewModel.appleLogin(email: email, name: name)
                }
            } else {
                print(credential.user)
                guard let data = UserDefaults.standard.appleUserData,
                      let appleUser = try? JSONDecoder().decode(AppleUserData.self, from: data)
                else { return }
                self.animateSpinner()
                self.viewModel.appleLogin(email: appleUser.email, name: "\(appleUser.firstName) \(appleUser.lastName)")
            }
        default:
            print("...")
        }
    }

    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential {
//        case let credential as ASAuthorizationAppleIDCredential:
//            if let appleUser = appleUser(credentials: credential),
//               let appleUserData = try? JSONEncoder().encode(appleUser){
//                do {
//                    UserDefaults.standard.set(appleUserData, forKey: credential.user)
//                    self.viewModel.appleLogin(email: credential.email ?? "", name: (credential.fullName?.givenName ?? "") + (credential.fullName?.familyName ?? ""))
//                }
//            }
//            else{
//                print(UserDefaults.standard.data(forKey: credential.user))
//                guard let appleUserData = UserDefaults.standard.data(forKey: credential.user),
//                      let appleUser = try? JSONDecoder().decode(appleUser.self, from: appleUserData)
//                 else { return }
//                self.animateSpinner()
//                self.viewModel.appleLogin(email: appleUser.email, name: appleUser.firstName + appleUser.lastName)
//            }
//        default:
//            print("...")
//        }
//    }
}

extension  LoginViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
}

