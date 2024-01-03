//
//  FilterViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

import UIKit
import WARangeSlider
class FilterViewController: UIViewController {

    @IBOutlet weak var rangeSlider: RangeSlider!
    @IBOutlet weak var filterButtton: UIButton!
    @IBOutlet weak var maximumLabel: UILabel!
    @IBOutlet weak var minimumLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var sourcesLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    let pickerView = UIPickerView()
    var viewModel = FilterViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        minimumLabel.attributedText = Helper.attributedText(text1: "50 ", text2: LocalizationKeys.sar.rawValue.localizeString())
        maximumLabel.attributedText = Helper.attributedText(text1: "5000 ", text2: LocalizationKeys.sar.rawValue.localizeString())
        sourcesLabel.text = LocalizationKeys.selectedSources.rawValue.localizeString()
        priceRangeLabel.text = LocalizationKeys.selectPriceRange.rawValue.localizeString()
        filterButtton.setTitle(LocalizationKeys.applyFilter.rawValue.localizeString(), for: .normal)
        textField.textAlignment = Helper.isRTL() == true ? .right : .left
        textField.placeholder = LocalizationKeys.allSources.rawValue.localizeString()
        viewModel.sourcesList.bind { [unowned self] _ in
            self.pickerView.reloadInputViews()
        }
        viewModel.getSourcesList()
        rangeSlider.addTarget(self, action: #selector(FilterViewController.rangeSliderValueChanged(_:)), for: .valueChanged)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        let lowerValue = Int(rangeSlider.lowerValue)
        let upperValue = Int(rangeSlider.upperValue)
        minimumLabel.attributedText = Helper.attributedText(text1: "\(lowerValue) ", text2: LocalizationKeys.sar.rawValue.localizeString())
        maximumLabel.attributedText = Helper.attributedText(text1: "\(upperValue) ", text2: LocalizationKeys.sar.rawValue.localizeString())
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getTitle(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = viewModel.getTitle(at: row)
    }
}

