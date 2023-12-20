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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        viewControllerTitle = LocalizationKeys.personalInformation.rawValue.localizeString()
        editButtons.forEach { button in
            button.setTitle(LocalizationKeys.edit.rawValue.localizeString(), for: .normal)
        }
        saveButton.setTitle(LocalizationKeys.save.rawValue.localizeString(), for: .normal)
        updateUI()
        viewModel.myProfile.bind { _ in
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
        viewModel.getMyProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.nameView.isHidden = true
        headerView.emailView.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        
    }
    
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
    }
    
    @IBAction func updateBtnAction(_ sender: Any) {
    }
}
