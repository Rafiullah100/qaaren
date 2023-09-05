//
//  AlertViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/4/23.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var radioButtonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func radioButtonAction(_ sender: Any) {
        if radioButtonView.layer.borderWidth == 1{
            radioButtonView.layer.borderColor = CustomColor.appSecondryColor.color.cgColor
            radioButtonView.layer.borderWidth = 8
        }
        else{
            radioButtonView.layer.borderColor = CustomColor.borderColor.color.cgColor
            radioButtonView.layer.borderWidth = 1
        }
    }
}
