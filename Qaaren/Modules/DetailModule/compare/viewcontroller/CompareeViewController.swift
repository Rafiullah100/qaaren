//
//  CompareeViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/31/23.
//

import UIKit

class CompareeViewController: UIViewController {

    

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CompareTableViewCell", bundle: nil), forCellReuseIdentifier: CompareTableViewCell.cellReuseIdentifier())
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.tableView.reloadData()
//        tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
//        tableView.reloadData()
//        tableView.layoutIfNeeded()
        tableViewHeight.constant = tableView.contentSize.height
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        self.tableViewHeight.constant = self.tableView.contentSize.height
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tableViewHeight.constant = self.tableView.contentSize.height
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CompareeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CompareTableViewCell = tableView.dequeueReusableCell(withIdentifier: CompareTableViewCell.cellReuseIdentifier()) as! CompareTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
}

