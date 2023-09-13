//
//  NewsView.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/3/23.
//

import UIKit

protocol ButtonViewDelegate {
    func buttonAction(type: ButtonType)
}

enum ButtonType {
    case category
    case source
}

class ButtonsView: UIView {
   
    @IBOutlet weak var sourcesButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var sourcesButtonView: UIView!
    @IBOutlet weak var categoryButtonView: UIView!
        var delegate: ButtonViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }
    
    private func commoninit(){
        let buttonsView = Bundle.main.loadNibNamed("ButtonsView", owner: self, options: nil)![0] as! UIView
        buttonsView.frame = self.bounds
        buttonsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(buttonsView)
//        newsButtonView.viewShadow(CustomColor.shadowColor)
        setupView(.category)
        
        sourcesButton.setTitle(LocalizationKeys.sources.rawValue.localizeString(), for: .normal)
        categoryButton.setTitle(LocalizationKeys.categories.rawValue.localizeString(), for: .normal)
    }

    @IBAction func categoryBtnAction(_ sender: Any) {
        delegate?.buttonAction(type: .category)
        setupView(.category)
    }
    
    @IBAction func sourcesBtnAction(_ sender: Any) {
        delegate?.buttonAction(type: .source)
        setupView(.source)
    }
    
    func setupView(_ type: ButtonType) {
        if type == .category{
            categoryButtonView.backgroundColor = CustomColor.uiColor(.appColor)
            categoryButton.setTitleColor(.white, for: .normal)
            sourcesButton.setTitleColor(CustomColor.uiColor(.tabTextColor), for: .normal)
            sourcesButtonView.backgroundColor = CustomColor.uiColor(.buttonColor)
            
            categoryButton.titleLabel?.font = UIFont(name: Constants.fontNameMedium, size: 17.0)
            sourcesButton.titleLabel?.font = UIFont(name: Constants.fontRegular, size: 17.0)
        }
        else{
            sourcesButtonView.backgroundColor = CustomColor.uiColor(.appColor)
            sourcesButton.setTitleColor(.white, for: .normal)
            categoryButton.setTitleColor(CustomColor.uiColor(.tabTextColor), for: .normal)
            categoryButtonView.backgroundColor = CustomColor.uiColor(.buttonColor)
            
            sourcesButton.titleLabel?.font = UIFont(name: Constants.fontNameMedium, size: 17.0)
            categoryButton.titleLabel?.font = UIFont(name: Constants.fontRegular, size: 17.0)
        }
    }
}
