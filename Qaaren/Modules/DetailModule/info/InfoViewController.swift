//
//  InfoViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/1/23.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    var descriptionText: String?{
        didSet{
            textView.attributedText = descriptionText?.htmlToAttributedString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
    }
}
