//
//  ProfileViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/19/23.
//

import Foundation
import UIKit
class ProfileViewModel {
    
    var myProfile: Observable<ProfileModel> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var parameters: [String: Any]?
    var editProfile: Observable<EditProfileModel> = Observable(nil)
    var deleteAccount: Observable<DeleteModel> = Observable(nil)

    func getMyProfile(){
        URLSession.shared.request(route: .myProfile, method: .get, parameters: [:], model: ProfileModel.self) { result in
            switch result {
            case .success(let myProfile):
                print(myProfile)
                self.myProfile.value = myProfile
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getName() -> String {
        return myProfile.value?.customer?.fullName ?? ""
    }
    
    func getEmail() -> String {
        return myProfile.value?.customer?.email ?? ""
    }
    
    func getMobile() -> String {
        return myProfile.value?.customer?.contactNo ?? ""
    }
    
    func getImage() -> String {
        return myProfile.value?.customer?.profileImage ?? ""
    }
    
    func isFormValid(user: EditProfileInputModel) -> ValidationResponse {
        if user.name.isEmpty || user.email.isEmpty || user.mobile.isEmpty || user.image == nil {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if !Helper.isValidEmail(email: user.email){
            return ValidationResponse(isValid: false, message: "Please enter a valid email!")
        }
        else{
            parameters = ["full_name": user.name, "email": user.email, "contact_no": user.mobile, "profile": user.image!]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func updateProfile(image: UIImage)  {
        Networking.shared.updateProfile(route: .updateProfile, imageParameter: "profile", image: image, parameters: parameters ?? [:]) { result in
            switch result {
            case .success(let profile):
                print(profile)
                self.editProfile.value = profile
                self.saveUser()
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func delete(){
        URLSession.shared.request(route: .deleteAccount, method: .post, parameters: [:], model: DeleteModel.self) { result in
            switch result {
            case .success(let delete):
                self.deleteAccount.value = delete
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func saveUser(){
        UserDefaults.standard.profileImage = self.editProfile.value?.customer?.profileImage
        UserDefaults.standard.email = self.editProfile.value?.customer?.email
        UserDefaults.standard.name = self.editProfile.value?.customer?.fullName
    }
}
