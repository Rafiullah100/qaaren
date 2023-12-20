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
            if isViewLoaded{
                textView.text = descriptionText
            }
        }
    }
    
    private func updateTextView() {
        textView.text = descriptionText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
    }
}
