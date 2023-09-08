//
//  MyCategoryViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/8/23.
//

import UIKit

class MyCategoryViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "SelectedCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedCategoryTableViewCell.cellReuseIdentifier())
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .backWithTitle
        viewControllerTitle = "My Categories"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension MyCategoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectedCategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: SelectedCategoryTableViewCell.cellReuseIdentifier()) as! SelectedCategoryTableViewCell
//        cell.titleLabel.text = "Wearables"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
