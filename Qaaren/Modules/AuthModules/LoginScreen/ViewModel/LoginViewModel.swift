//
//  LoginViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 10/11/23.
//

import Foundation


class LoginViewModel {
    
    var bindResultToView: (() -> ()) = {}
    
    var login: LoginModel? {
        didSet{
            self.saveUserPreference()
            self.bindResultToView()
        }
    }
    
    var parameters: [String: Any]?

    func isFormValid(user: LoginInputModel) -> ValidationResponse {
        if user.email.isEmpty || user.password.isEmpty {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            parameters = ["username": user.email, "password": user.password]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func loginUser(){
        URLSession.shared.request(route: .login, method: .post, parameters: parameters, model: LoginModel.self) { result in
            switch result {
            case .success(let login):
                self.login = login
            case .failure(let error):
                print(error)
                self.login = nil
            }
        }
    }
    
    private func saveUserPreference(){
        UserDefaults.standard.name = self.login?.user?.fullName
        UserDefaults.standard.email = self.login?.user?.email
        UserDefaults.standard.profileImage = self.login?.user?.profileImage
        UserDefaults.standard.token = self.login?.user?.token
        UserDefaults.standard.mobile = self.login?.user?.contactNo
        UserDefaults.standard.uuid = self.login?.user?.uuid
        UserDefaults.standard.isLogin = true
    }
}
