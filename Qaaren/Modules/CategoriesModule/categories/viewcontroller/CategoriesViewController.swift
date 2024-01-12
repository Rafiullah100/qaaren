//
//  CategoriesViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/5/23.
//

import UIKit

class CategoriesViewController: BaseViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: CategoriesTableViewCell.cellReuseIdentifier())
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    private var selectedIndex: IndexPath?{
        didSet{
            guard let catID = viewModel.getCatID(for: selectedIndex?.row ?? 0) else {return}
            viewModel.addCategory(categoryId: catID)
        }
    }
    
    var viewModel = AllCategoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = LocalizationKeys.allCategories.rawValue.localizeString()
        
        self.animateSpinner()
        viewModel.categories.bind { [unowned self] allCategories in
            guard let _ = allCategories else{return}
            DispatchQueue.main.async {
                self.stopAnimation()
                self.viewModel.getCount() == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
            }
        }
        
        viewModel.success.bind { success in
            guard success?.status == 1 else{ return }
            self.viewModel.ChangeCategoyStatus(for: self.selectedIndex?.row ?? 0)
            self.tableView.reloadRows(at: [self.selectedIndex ?? IndexPath()], with: .automatic)
        }
        viewModel.getAllCategories()
    }
    
//
//    private func bindView(){
//        self.animateSpinner()
//        viewModel.categories.bind { allCategories in
//            self.stopAnimation()
//            self.tableView.reloadData()
//        }
//
//        viewModel.success.bind { success in
//            guard success?.status == 1 else{return}
//            self.viewModel.ChangeCategoyStatus(for: self.selectedIndex?.row ?? 0)
//            self.tableView.reloadRows(at: [self.selectedIndex ?? IndexPath()], with: .automatic)
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    @IBAction func filterBtnAction(_ sender: Any) {
        Switcher.gotoFilterVC(delegate: self)
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoriesTableViewCell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.cellReuseIdentifier()) as! CategoriesTableViewCell
        guard let category = viewModel.getCategory(for: indexPath.row) else { return cell }
        cell.category = category
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
