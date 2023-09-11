//
//  FilterViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    let pickerView = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.source.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.source[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = Constants.source[row]
    }
}

