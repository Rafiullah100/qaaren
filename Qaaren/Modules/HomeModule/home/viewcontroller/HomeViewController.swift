//
//  HomeViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit

class HomeViewController: UIViewController {

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
    var viewModel = HomeViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.itemsArray = ["All", "Home", "Electronics", "Clothings", "Grocery", "Photography", "Gaming & Entertainment", "Beauty and Health"]
        selectedIndexPath = IndexPath(row: 0, section: 0)
    }
    
    @IBAction func filterBtnAction(_ sender: Any) {
        Switcher.gotoFilterVC(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TabCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! TabCollectionViewCell
        cell.nameLabel.text = viewModel.itemsArray[indexPath.row]
        cell.iconView.isHidden = true
        if indexPath == selectedIndexPath {
            cell.cardView.removeShadow()
            cell.cardView.backgroundColor = CustomColor.appColor.color
            cell.nameLabel.textColor = .white
        } else {
            cell.cardView.addShadow()
            cell.nameLabel.textColor = CustomColor.uiColor(.tabTextColor)
            cell.cardView.backgroundColor = CustomColor.uiColor(.tabBGColor)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewModel.itemsArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont(name: Constants.fontNameMedium, size: 16.0) ?? UIFont()]).width + 35, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellReuseIdentifier()) as! HomeTableViewCell
        cell.didTappedProduct = {
            Switcher.gotoDetailVC(delegate: self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360.0
    }
}
