//
//  SignupViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 10/11/23.
//

import Foundation

class SignupViewModel {
    var errorMessage: Observable<String> = Observable("")
    var signup: Observable<SignupModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(user: SignupInputModel) -> ValidationResponse {
        if user.name.isEmpty || user.email.isEmpty || user.password.isEmpty || user.confirm.isEmpty {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if !Helper.isValidEmail(email: user.email){
            return ValidationResponse(isValid: false, message: "Please enter a valid email!")
        }
        else if user.password != user.confirm{
            return ValidationResponse(isValid: false, message: "Password doesn't match!")
        }
        else{
            parameters = ["full_name": user.name, "username": user.email, "password": user.password, "confirm_password": user.confirm]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func signupUser(){
        URLSession.shared.request(route: .signup, method: .post, parameters: parameters, model: SignupModel.self) { result in
            switch result {
            case .success(let signup):
                self.signup.value = signup
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
