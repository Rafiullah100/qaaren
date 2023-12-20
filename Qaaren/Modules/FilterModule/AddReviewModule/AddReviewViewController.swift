//
//  AddReviewViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/12/23.
//

import UIKit

class AddReviewViewController: UIViewController {

    @IBOutlet var ratingImageView: [UIImageView]!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var reviewLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = LocalizationKeys.addReview.rawValue.localizeString()
        reviewLabel.text = LocalizationKeys.addReview.rawValue.localizeString()
        submitButton.setTitle(LocalizationKeys.submitReview.rawValue.localizeString(), for: .normal)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
    }
}
