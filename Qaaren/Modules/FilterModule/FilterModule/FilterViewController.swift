//
//  FilterViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var filterButtton: UIButton!
    @IBOutlet weak var maximumLabel: UILabel!
    @IBOutlet weak var minimumLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var sourcesLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    let pickerView = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        
        sourcesLabel.text = LocalizationKeys.selectedSources.rawValue.localizeString()
        priceRangeLabel.text = LocalizationKeys.selectPriceRange.rawValue.localizeString()
        minimumLabel.attributedText = Helper.attributedText(text1: "500 ", text2: LocalizationKeys.sar.rawValue.localizeString())
        maximumLabel.attributedText = Helper.attributedText(text1: "5000 ", text2: LocalizationKeys.sar.rawValue.localizeString())
        filterButtton.setTitle(LocalizationKeys.applyFilter.rawValue.localizeString(), for: .normal)
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

