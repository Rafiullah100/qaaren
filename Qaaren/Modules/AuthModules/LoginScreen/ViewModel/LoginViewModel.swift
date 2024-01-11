//
//  LoginViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 10/11/23.
//

import Foundation
import AuthenticationServices

struct AppleUserData: Codable {
    let userID: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential) {
        guard let firstName = credentials.fullName?.givenName,
              let lastName = credentials.fullName?.familyName,
              let email = credentials.email
        else { return nil }
        self.userID = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

class LoginViewModel {
    var isUserExist: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String> = Observable("")
    var login: LoginModel?
    var isAuthenticationInProgress: Bool = false
    var googleLogin: Observable<SuccessModel> = Observable(nil)
    var appleLogin: AppleLoginModel?

    var parameters: [String: Any]?
    
    func isFormValid(user: LoginInputModel) -> ValidationResponse {
        if user.email.isEmpty || user.password.isEmpty {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if !Helper.isValidEmail(email: user.email){
            return ValidationResponse(isValid: false, message: "Please enter a valid email!")
        }
        else{
            parameters = ["username": user.email, "password": user.password]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func authenticateUser(){
        URLSession.shared.request(route: .login, method: .post, parameters: parameters, model: LoginModel.self) { result in
            switch result {
            case .success(let login):
                self.isUserExist.value = login.success
                if login.success == true{
                    self.login = login
                    self.saveUserPreference()
                }
                else{
                    self.errorMessage.value = login.message
                }
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func googleSignin(email: String, name: String) {
        URLSession.shared.request(route: .googleSignin, method: .post, parameters: ["username": email, "full_name": name], model: LoginModel.self) { result in
            switch result {
            case .success(let login):
                self.isUserExist.value = login.success
                if login.success == true{
                    self.login = login
                    self.saveUserPreference()
                }
                else{
                    self.errorMessage.value = login.message
                }
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func appleLogin(email: String, name: String) {
        print(email, name)
        URLSession.shared.request(route: .appleLogin, method: .post, parameters: ["username": email, "full_name": name], model: AppleLoginModel.self) { result in
            switch result {
            case .success(let appleLogin):
                self.isUserExist.value = appleLogin.success
                if appleLogin.success == true{
                    self.appleLogin = appleLogin
                    self.saveAppleUserPreference()
                }
                else{
                    self.errorMessage.value = appleLogin.message
                }
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func saveUserPreference(){
        UserDefaults.standard.name = self.login?.user?.fullName
        UserDefaults.standard.email = self.login?.user?.email
        UserDefaults.standard.profileImage = self.login?.user?.profileImage
        UserDefaults.standard.token = self.login?.user?.token
        UserDefaults.standard.mobile = self.login?.user?.contactNo
        UserDefaults.standard.uuid = self.login?.user?.uuid
        UserDefaults.standard.isLogin = true
    }
    
    func saveAppleUserPreference(){
        UserDefaults.standard.name = self.appleLogin?.user?.fullName
        UserDefaults.standard.email = self.appleLogin?.user?.email
        UserDefaults.standard.profileImage = self.appleLogin?.user?.profileImage
        UserDefaults.standard.token = self.appleLogin?.user?.token
        UserDefaults.standard.mobile = self.appleLogin?.user?.contactNo
        UserDefaults.standard.uuid = self.appleLogin?.user?.uuid
        UserDefaults.standard.isLogin = true
    }
}
