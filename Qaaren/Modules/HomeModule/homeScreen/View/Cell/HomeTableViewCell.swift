//
//  HomeTableViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/29/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {


    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    var didTappedProduct: ((Int) -> Void)? = nil
    var subCategory: SubCategoryModel?{
        didSet{
            collectionView.reloadData()
            headerLabel.text = subCategory?.title
        }
    }
    
    var type: CardType?
    var indexPath: IndexPath?
    var didTappedViewAll: (() -> Void)? = nil

    
    var wishlistCategory: Wishlist? {
        didSet {
            collectionView.reloadData()
            headerLabel.text = wishlistCategory?.category
        }
    }
    
    let viewModel = ProductCellViewModel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        headerLabel.text = LocalizationKeys.google.rawValue.localizeString()
        viewAllButton.setTitle(LocalizationKeys.viewAll.rawValue.localizeString(), for: .normal)
        viewModel.success.bind { response in
            guard response?.success == true else {return}
            guard let indexPath = self.indexPath else{return}
            let isWishlist = self.subCategory?.catalogue?[indexPath.row].isWishlist
            self.subCategory?.catalogue?[indexPath.row].isWishlist = isWishlist == 0 ? 1 : 0
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [indexPath])
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewAllBtnAction(_ sender: Any) {
        didTappedViewAll?()
    }
}


extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type == .favorite ? wishlistCategory?.products?.count ?? 0 : subCategory?.catalogue?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProductCollectionViewCell
        if type == .home {
            cell.product = subCategory?.catalogue?[indexPath.row]
        }
        else if type == .favorite{
            cell.wishlistProduct = wishlistCategory?.products?[indexPath.row]
        }
        
        cell.didTappedFavorite = {
            let productID = self.type == .home ? self.subCategory?.catalogue?[indexPath.row].id : self.wishlistCategory?.products?[indexPath.row].catalogues?.id
            self.indexPath = indexPath
            self.viewModel.makeFavorite(productID: productID ?? 0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 10
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        type == .home ? didTappedProduct?(subCategory?.catalogue?[indexPath.row].id ?? 0) : didTappedProduct?(wishlistCategory?.products?[indexPath.row].catalogues?.id ?? 0)
    }
}

