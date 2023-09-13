//
//  SourcesViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/8/23.
//

import UIKit

class SourcesViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: CategoriesTableViewCell.cellReuseIdentifier())
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = LocalizationKeys.allSources.rawValue.localizeString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    @IBAction func filterBtnAction(_ sender: Any) {
        Switcher.gotoFilterVC(delegate: self)
    }
}

extension SourcesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoriesTableViewCell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.cellReuseIdentifier()) as! CategoriesTableViewCell
        cell.titleLabel.text = "Amazon SA"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
