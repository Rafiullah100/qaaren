//
//  RevieweViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/1/23.
//

import UIKit

class RevieweViewController: UIViewController {

    @IBOutlet weak var tableView: AutoSizingUiTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.cellReuseIdentifier())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.numberOfRows = 5
        tableView.cellHeight = 200.0
        tableView.estimatedRowHeight = 44.0
    }
}


extension RevieweViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellReuseIdentifier()) as! ReviewTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
