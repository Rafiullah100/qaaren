//
//  InformationViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/7/23.
//

import UIKit

class InformationViewController: BaseViewController {
    @IBOutlet var editButtons: [UIButton]!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var headerView: HeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        viewControllerTitle = LocalizationKeys.personalInformation.rawValue.localizeString()
        editButtons.forEach { button in
            button.setTitle(LocalizationKeys.edit.rawValue.localizeString(), for: .normal)
        }
        saveButton.setTitle(LocalizationKeys.save.rawValue.localizeString(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.nameView.isHidden = true
        headerView.emailView.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
