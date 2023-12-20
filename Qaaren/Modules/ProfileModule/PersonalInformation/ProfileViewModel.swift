//
//  ProfileViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/19/23.
//

import Foundation

class ProfileViewModel {
    
    var myProfile: Observable<ProfileModel> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    
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
}
