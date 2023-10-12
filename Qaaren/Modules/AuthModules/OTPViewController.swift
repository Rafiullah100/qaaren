//
//  OTPViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 10/10/23.
//

import UIKit
import OTPFieldView
class OTPViewController: BaseViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var otpTextField: OTPFieldView!
    
    var email: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationItem.hidesBackButton = true
        type = .center
        viewControllerTitle = "Email Conifirmation"
        setupOtpView()
        emailLabel.text = email
    }
    
    func setupOtpView(){
        self.otpTextField.fieldsCount = 4
        self.otpTextField.fieldBorderWidth = 2
        self.otpTextField.defaultBorderColor = UIColor.black
        self.otpTextField.filledBorderColor = UIColor.black
        self.otpTextField.cursorColor = UIColor.black
        self.otpTextField.displayType = .underlinedBottom
        self.otpTextField.fieldSize = 50
//        self.otpTextField.separatorSpace = 80.0
        self.otpTextField.shouldAllowIntermediateEditing = false
//        self.otpTextField.delegate = self
        self.otpTextField.initializeUI()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
