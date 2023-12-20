//
//  CategorySourcesViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/8/23.
//

import UIKit

class CategorySourcesViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var buttonsView: ButtonsView!
    @IBOutlet weak var containerView: UIView!
    
    let categoryVC = UIStoryboard(name: Storyboard.category.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
    let sourceVC = UIStoryboard(name: Storyboard.category.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SourcesViewController") as! SourcesViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.setTitle(LocalizationKeys.continueTitle.rawValue.localizeString(), for: .normal)
        buttonsView.delegate = self
        add(categoryVC, in: containerView)
    }
}

extension CategorySourcesViewController: ButtonViewDelegate{
    func buttonAction(type: ButtonType) {
        if type == .category{
            add(categoryVC, in: containerView)
        }
        else{
            add(sourceVC, in: containerView)
        }
    }
}
