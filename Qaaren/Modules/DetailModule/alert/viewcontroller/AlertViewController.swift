//
//  AlertViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/4/23.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var notifymeLabel: UILabel!
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var radioButtonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = LocalizationKeys.receiveAlert.rawValue.localizeString()
        notifymeLabel.text = LocalizationKeys.priceDropped.rawValue.localizeString()
        createLabel.text = LocalizationKeys.createAlert.rawValue.localizeString()
    }
    
    @IBAction func radioButtonAction(_ sender: Any) {
        if radioButtonView.layer.borderWidth == 1{
            radioButtonView.layer.borderColor = CustomColor.uiColor(.blueishColor).cgColor
            radioButtonView.layer.borderWidth = 8
        }
        else{
            radioButtonView.layer.borderColor = CustomColor.borderColor.color.cgColor
            radioButtonView.layer.borderWidth = 1
        }
    }
}
