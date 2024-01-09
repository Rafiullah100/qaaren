//
//  FilterListViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 1/9/24.
//

import UIKit

class FilterListViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    var sourceId: Int!
    var minPrice: Int!
    var maxPrice: Int!
    
    var viewModel = FilterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        self.animateSpinner()
        viewModel.filteredData.bind { [unowned self] _ in
            self.stopAnimation()
            self.collectionView.reloadData()
        }
        viewModel.getFilteredData(from: maxPrice, to: minPrice, for: sourceId)
    }
}

extension FilterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getFilterCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! FilterCollectionViewCell
        cell.product = viewModel.getFilterProduct(for: indexPath.row)
//        cell.didTappedFavorite = {
//            self.showMessage()
//            let productID = self.type == .home ? self.subCategory?.catalogue?[indexPath.row].id : self.wishlistCategory?.products?[indexPath.row].catalogues?.id
//            self.indexPath = indexPath
//            self.viewModel.makeFavorite(productID: productID ?? 0)
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 10
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoDetailVC(delegate: self, productID: viewModel.getSourceId(for: indexPath.row))
    }
}
