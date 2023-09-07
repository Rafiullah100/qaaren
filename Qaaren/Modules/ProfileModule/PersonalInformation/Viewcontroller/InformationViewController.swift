//
//  InformationViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/7/23.
//

import UIKit

class InformationViewController: BaseViewController {

    @IBOutlet weak var headerView: HeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()

        type = .backWithTitle
        viewControllerTitle = "Personal Information"
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
