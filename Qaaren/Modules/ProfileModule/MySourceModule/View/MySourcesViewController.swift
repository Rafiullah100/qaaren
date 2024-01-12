//
//  MySourcesViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/8/23.
//

import UIKit

class MySourcesViewController: BaseViewController {

    @IBOutlet weak var browseLabel: UILabel!
    @IBOutlet weak var sourcesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "SelectedCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedCategoryTableViewCell.cellReuseIdentifier())
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    private var viewModel = MySourcesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        viewControllerTitle = LocalizationKeys.mySources.rawValue.localizeString()
        sourcesLabel.text = LocalizationKeys.selectedSources.rawValue.localizeString()
        browseLabel.text = LocalizationKeys.selectedSources.rawValue.localizeString()
        
        viewModel.getMyCategories()
        self.animateSpinner()
        viewModel.mySources.bind { [unowned self] sources in
            guard let _ = sources else{return}
            DispatchQueue.main.async {
                self.stopAnimation()
                self.viewModel.getCount() == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension MySourcesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectedCategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: SelectedCategoryTableViewCell.cellReuseIdentifier()) as! SelectedCategoryTableViewCell
        cell.titleLabel.text = viewModel.getMySource(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
