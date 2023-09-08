//
//  LoginViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        UIWindow.key?.overrideUserInterfaceStyle = .dark
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func skipLoginButton(_ sender: Any) {
        Switcher.gotoHomeVC(delegate: self)
    }
}
