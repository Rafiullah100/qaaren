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
    
    private let pickerView = UIPickerView()
    private let viewModel = AlertViewModel()
    var productID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        emailTextField.inputView = pickerView
//        emailTextField.placeholder = LocalizationKeys.receiveAlert.rawValue.localizeString()
        emailTextField.placeholder = "Select event"
        notifymeLabel.text = LocalizationKeys.priceDropped.rawValue.localizeString()
        createLabel.text = LocalizationKeys.createAlert.rawValue.localizeString()
        
        viewModel.alert.bind { [unowned self] alert in
            showAlert(message: alert?.message ?? "")
        }
    }
    
    @IBAction func radioButtonAction(_ sender: Any) {
        if emailTextField.text == "" {
            showAlert(message: "Please select event type!")
        }
        else{
            viewModel.callAlert(eventType: emailTextField.text ?? "", productID: productID ?? 0)
        }
    }
}


extension AlertViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }

      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return viewModel.eventType().count
      }

      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return viewModel.getTitle(at: row).capitalized
      }

      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          emailTextField.text = viewModel.getTitle(at: row).capitalized
      }
}
