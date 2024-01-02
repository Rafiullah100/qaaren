//
//  SourcesViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/8/23.
//

import UIKit

class SourcesViewController: BaseViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: CategoriesTableViewCell.cellReuseIdentifier())
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var viewModel = AllCategoryViewModel()
    private var selectedIndex: IndexPath?{
        didSet{
            guard let sourceID = viewModel.getSourceID(for: selectedIndex?.row ?? 0) else {return}
            viewModel.addSource(sourceID: sourceID)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = LocalizationKeys.allSources.rawValue.localizeString()
        self.animateSpinner()
        viewModel.getAllSources()
        viewModel.sources.bind { _ in
            self.stopAnimation()
            self.viewModel.getSourcesCount() == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
        }
        
        viewModel.success.bind { success in
            guard success?.status == 1 else{return}
            self.viewModel.ChangeSourceStatus(for: self.selectedIndex?.row ?? 0)
            self.tableView.reloadRows(at: [self.selectedIndex ?? IndexPath()], with: .automatic)
        }
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
        return viewModel.getSourcesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoriesTableViewCell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.cellReuseIdentifier()) as! CategoriesTableViewCell
        cell.source = viewModel.getSources(for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard Helper.isLogin() == true else {return self.view.makeToast("You're not login", position: .center)}
        selectedIndex = indexPath
    }
}
