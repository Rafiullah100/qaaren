//
//  SignupViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 10/11/23.
//

import Foundation

class SignupViewModel {
    var parameters: [String: Any]?
    var bindResultToView: (() -> Void) = { }
    
    var signup: SignupModel? {
        didSet{
            self.bindResultToView()
        }
    }

    func isFormValid(user: SignupInputModel) -> ValidationResponse {
        if user.name.isEmpty || user.email.isEmpty || user.password.isEmpty || user.confirm.isEmpty {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if user.password != user.confirm{
            return ValidationResponse(isValid: false, message: "Password doesn't match!")
        }
        else{
            parameters = ["full_name": user.name, "username": user.email, "password": user.password, "confirm_password": user.confirm]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func SignupUser(){
        URLSession.shared.request(route: .signup, method: .post, parameters: parameters, model: SignupModel.self) { result in
            switch result {
            case .success(let signup):
                self.signup = signup
            case .failure(let error):
                self.signup = nil
            }
        }
    }
}
