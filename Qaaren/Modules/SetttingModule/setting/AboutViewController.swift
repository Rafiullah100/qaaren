//
//  AboutViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/26/23.
//

import UIKit

class AboutViewController: BaseViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        viewControllerTitle = "About Qaaren"
        textView.attributedText = Helper.parseLocalHtml(Constants.aboutQaaren)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
