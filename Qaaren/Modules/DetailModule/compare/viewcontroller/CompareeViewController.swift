//
//  CompareeViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/31/23.
//

import UIKit

class CompareeViewController: UIViewController {

    

    @IBOutlet weak var tableView: AutoSizingUiTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CompareTableViewCell", bundle: nil), forCellReuseIdentifier: CompareTableViewCell.cellReuseIdentifier())
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        self.view.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.numberOfRows = 10
        tableView.cellHeight = 190.0
    }
}

extension CompareeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CompareTableViewCell = tableView.dequeueReusableCell(withIdentifier: CompareTableViewCell.cellReuseIdentifier()) as! CompareTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
}

