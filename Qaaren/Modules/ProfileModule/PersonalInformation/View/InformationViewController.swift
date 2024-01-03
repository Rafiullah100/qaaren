//
//  InformationViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/7/23.
//

import UIKit
import SDWebImage
class InformationViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet var editButtons: [UIButton]!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    
    private var viewModel = ProfileViewModel()
    var imagePicker: UIImagePickerController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        nameTextField.textAlignment = Helper.isRTL() == true ? .right : .left
        emailTextField.textAlignment = Helper.isRTL() == true ? .right : .left
        mobileTextField.textAlignment = Helper.isRTL() == true ? .right : .left
        viewControllerTitle = LocalizationKeys.personalInformation.rawValue.localizeString()
        editButtons.forEach { button in
            button.setTitle(LocalizationKeys.edit.rawValue.localizeString(), for: .normal)
        }
        saveButton.setTitle(LocalizationKeys.save.rawValue.localizeString(), for: .normal)
        updateButton.setTitle(LocalizationKeys.updatePassword.rawValue.localizeString(), for: .normal)
        updateUI()
        self.animateSpinner()
        viewModel.myProfile.bind { _ in
            DispatchQueue.main.async {
                self.stopAnimation()
                self.updateUI()
            }
        }
        viewModel.getMyProfile()
        
        headerView.didTappedCamera = {
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                self.selectImageFrom(.photoLibrary)
                return
            }
            self.selectImageFrom(.camera)
        }
        
        viewModel.editProfile.bind { [unowned self] editProfile in
            self.stopAnimation()
            self.showAlert(message: editProfile?.message ?? "")
        }
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        headerView.nameView.isHidden = true
//        headerView.emailView.isHidden = true
        headerView.cameraView.isHidden = false
//        headerView.logoutButtonView.isHidden = true
        headerView.imageView.layer.cornerRadius = headerView.imageView.frame.height * 0.5
    }
    
    private func updateUI(){
        print(viewModel.getName())
        nameTextField.text = viewModel.getName()
        emailTextField.text = viewModel.getEmail()
        headerView.imageView.sd_setImage(with: URL(string: Route.baseUrl + viewModel.getImage()), placeholderImage: UIImage(named: "placeholder"))
        mobileTextField.text = viewModel.getMobile()
    }

    
    @IBAction func saveBtnAction(_ sender: Any) {
        let edit = EditProfileInputModel(name: nameTextField.text ?? "", email: emailTextField.text ?? "", mobile: mobileTextField.text ?? "", image: headerView.imageView.image ?? UIImage())
        let validationResponse = viewModel.isFormValid(user: edit)
        if validationResponse.isValid {
            self.animateSpinner()
            viewModel.updateProfile(image: headerView.imageView.image ?? UIImage())
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    @IBAction func updateBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func nameEditBtn(_ sender: Any) {
        nameTextField.becomeFirstResponder()
        nameTextField.isUserInteractionEnabled.toggle()
    }
    
    @IBAction func emailEditBtn(_ sender: Any) {
        emailTextField.becomeFirstResponder()
        emailTextField.isUserInteractionEnabled.toggle()
    }
    
    @IBAction func phoneEditBtn(_ sender: Any) {
        mobileTextField.becomeFirstResponder()
        mobileTextField.isUserInteractionEnabled.toggle()
    }
}

extension InformationViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        headerView.imageView.image = selectedImage
    }
}
