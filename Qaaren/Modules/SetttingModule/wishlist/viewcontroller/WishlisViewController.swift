//
//  WishlistViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/5/23.
//

import UIKit

class WishlisViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .backWithTitle
        viewControllerTitle = "My Wishlist"
    }
}

extension WishlisViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! ProductCollectionViewCell
        cell.type = .favorite
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 10
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: 280)
    }
}
