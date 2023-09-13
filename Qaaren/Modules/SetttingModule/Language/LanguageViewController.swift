//
//  LanguageViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/12/23.
//

import UIKit

class LanguageViewController: BaseViewController {
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var arabicButton: UIButton!
    
    @IBOutlet weak var arabicView: UIView!
    @IBOutlet weak var englishView: UIView!
    
    var selectedRadioButton: UIButton?

    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var arabicLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        type = .backWithTitle
        viewControllerTitle = LocalizationKeys.languageSelection.rawValue.localizeString()
        englishLabel.text = LocalizationKeys.english.rawValue.localizeString()
        arabicLabel.text = LocalizationKeys.arabic.rawValue.localizeString()
        saveButton.setTitle(LocalizationKeys.save.rawValue.localizeString(), for: .normal)
        
        if UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue{
            selectedRadioButton = englishButton
            radioButtonTapped(arabicButton)
        }
        else{
            selectedRadioButton = arabicButton
            radioButtonTapped(englishButton)
        }
    }

    @IBAction func english(_ sender: Any) {
//        selectedRadioButton?.isSelected = false
//        englishButton.isSelected = true
//        selectedRadioButton = englishButton
        radioButtonTapped(englishButton)
    }
    
    @IBAction func arabic(_ sender: Any) {
//        selectedRadioButton?.isSelected = false
//        arabicButton.isSelected = true
//        selectedRadioButton = arabicButton
        radioButtonTapped(arabicButton)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        Switcher.gotoHomeVC(delegate: self)
    }
    
    func radioButtonTapped(_ sender: UIButton) {
        selectedRadioButton?.isSelected = false
        selectedRadioButton?.layer.borderWidth = 1
        selectedRadioButton?.layer.borderColor = UIColor.gray.cgColor
        sender.isSelected = true
        sender.layer.borderWidth = 5
        sender.layer.borderColor = UIColor.blue.cgColor
        selectedRadioButton = sender
        if selectedRadioButton == englishButton {
            UserDefaults.standard.selectedLanguage = AppLanguage.english.rawValue
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        else{
            UserDefaults.standard.selectedLanguage = AppLanguage.arabic.rawValue
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
    }
}
