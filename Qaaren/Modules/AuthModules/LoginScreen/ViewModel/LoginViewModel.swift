//
//  LoginViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 10/11/23.
//

import Foundation


class LoginViewModel {
    var isUserExist: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String> = Observable("")
    var login: LoginModel?
    var isAuthenticationInProgress: Bool = false
    var googleLogin: Observable<SuccessModel> = Observable(nil)

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
    
    func googleSignin(email: String) {
        URLSession.shared.request(route: .googleSignin, method: .post, parameters: ["username": email], model: SuccessModel.self) { result in
            switch result {
            case .success(let google):
                self.googleLogin.value = google
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
}
