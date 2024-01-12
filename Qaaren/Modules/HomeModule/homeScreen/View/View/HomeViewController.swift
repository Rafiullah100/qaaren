//
//  HomeViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit
import SearchTextField
class HomeViewController: BaseViewController {

    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "TabCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TabCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: HomeTableViewCell.cellReuseIdentifier())
        }
    }
    
    var selectedIndexPath: IndexPath?
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animateSpinner()
        viewModel = HomeViewModel()
        bindCategoryResult()
        bindSubCategoryResult()
        
        searchTextField?.addTarget(self, action: #selector(HomeViewController.textFieldDidChange(_:)), for: .editingChanged)
        viewModel.search.bind { _ in
            self.searchTextField?.filterStrings(self.viewModel.getSearchTitles())
        }
        
        searchTextField.itemSelectionHandler = { filteredResults, itemPosition in
            guard let productID = self.viewModel.getSelectedProductID(at: itemPosition) else{return}
            print(productID)
            Switcher.gotoDetailVC(delegate: self, productID: productID)
        }
        viewModel.getCategories()
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(loadData),
                name: Notification.Name(Constants.notificationName),
                object: nil
            )
    }
    
    @objc private func loadData(){
        viewModel.getCategories()
    }
    
    private func bindCategoryResult(){
        viewModel.categories.bind({ [unowned self] _ in
            self.byDefaultSelected()
            viewModel.getCategoriesCount() == 0 ? nil : collectionView.reloadData()
            self.getSubCategory()
        })
    }
    
    private func getSubCategory(){
        self.animateSpinner()
        self.viewModel.getSubCategories(categoryID: viewModel.getCategoryID(selectedIndexPath?.row ?? 0))
    }
    
    private func bindSubCategoryResult(){
        viewModel.subCategories.bind({ [unowned self] subCat in
            guard let _ = subCat else { return }
            DispatchQueue.main.async {
                self.stopAnimation()
                self.viewModel.getSubCategoriesCount() == 0 ? self.tableView.setEmptyView() : self.tableView.setEmptyView("")
                self.tableView.reloadData()
            }
        })
    }
    
    private func byDefaultSelected(){
        selectedIndexPath = IndexPath(row: 0, section: 0)
    }
    
    @IBAction func filterBtnAction(_ sender: Any) {
        Switcher.gotoFilterVC(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.placeholder = LocalizationKeys.search.rawValue.localizeString()
        searchTextField.textAlignment = Helper.isRTL() == true ? .right : .left
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = searchTextField.text, !text.isEmpty else {
            self.searchTextField?.filterStrings([])
            return  }
        viewModel.fetchSearchResult(text: text)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCategoriesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TabCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! TabCollectionViewCell
        cell.nameLabel.text = viewModel.categoryTitle(at: indexPath.row)
        cell.iconView.isHidden = true
        if indexPath == selectedIndexPath {
            cell.isUserInteractionEnabled = false
            cell.cardView.removeShadow()
            cell.cardView.backgroundColor = CustomColor.appColor.color
            cell.nameLabel.textColor = .white
        } else {
            cell.isUserInteractionEnabled = true
            cell.cardView.addShadow()
            cell.nameLabel.textColor = CustomColor.uiColor(.tabTextColor)
            cell.cardView.backgroundColor = CustomColor.uiColor(.tabBGColor)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (viewModel.categoryTitle(at: indexPath.row).size(withAttributes: [NSAttributedString.Key.font : UIFont(name: Constants.fontNameMedium, size: 16.0) ?? UIFont()]).width) + 35, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        selectedIndexPath = indexPath
        self.getSubCategory()
        collectionView.reloadData()
    }    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSubCategoriesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellReuseIdentifier()) as! HomeTableViewCell
        cell.type = .home
        cell.subCategory = viewModel.getSubCategory(atIndex: indexPath.row)
        cell.didTappedProduct = { productID in
            Switcher.gotoDetailVC(delegate: self, productID: productID)
        }
        
        cell.didTappedViewAll = {
            Switcher.gotoViewAllScreen(delegate: self, productID: self.viewModel.getSubCategoryID(at: indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360.0
    }
}



