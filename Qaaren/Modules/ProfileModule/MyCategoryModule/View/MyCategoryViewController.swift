//
//  MyCategoryViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/8/23.
//

import UIKit

class MyCategoryViewController: BaseViewController {

    @IBOutlet weak var browseLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "SelectedCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedCategoryTableViewCell.cellReuseIdentifier())
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    private let viewModel = MyCategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        viewControllerTitle = LocalizationKeys.myCategories.rawValue.localizeString()
        categoriesLabel.text = LocalizationKeys.selectedCategories.rawValue.localizeString()
        browseLabel.text = LocalizationKeys.selectedSources.rawValue.localizeString()

        self.animateSpinner()
        viewModel.myCategories.bind { [unowned self] categories in
            guard let _ = categories else{return}
            DispatchQueue.main.async {
                self.stopAnimation()
                self.viewModel.getCount() == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
            }
        }
        viewModel.getMyCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension MyCategoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectedCategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: SelectedCategoryTableViewCell.cellReuseIdentifier()) as! SelectedCategoryTableViewCell
        cell.titleLabel.text = viewModel.getMyCategory(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
