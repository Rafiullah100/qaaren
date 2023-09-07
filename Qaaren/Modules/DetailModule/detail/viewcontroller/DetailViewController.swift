//
//  DetailViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "TabCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TabCollectionViewCell.cellReuseIdentifier())
        }
    }
    var selectedIndexPath: IndexPath?
    let viewModel = DetailViewModel()
    let compareVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompareeViewController") as! CompareeViewController
    let infoVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
    let reivewVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "RevieweViewController") as! RevieweViewController
    let alertVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
    let mapVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        add(compareVC, in: containerView)
        type = .detail
        collectionView.isScrollEnabled = false
        selectedIndexPath = IndexPath(row: 0, section: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TabCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! TabCollectionViewCell
        cell.nameLabel.text = viewModel.itemsArray[indexPath.row].title
        cell.nameLabel.isHidden = true
        cell.iconView.isHidden = false
        cell.nameLabel.textColor = .white
        cell.cardView.layer.cornerRadius = 0
        cell.nameLabel.font = UIFont(name: Constants.fontNameMedium, size: 19.0)
        cell.cardView.backgroundColor = CustomColor.tabBGColor.color
        if indexPath == selectedIndexPath {
            cell.iconView.image = UIImage(named: viewModel.itemsArray[indexPath.row].selectedImage)
            cell.nameLabel.isHidden = false
            cell.cardView.removeShadow()
            cell.cardView.backgroundColor = CustomColor.appColor.color
        } else {
            cell.iconView.image = UIImage(named: viewModel.itemsArray[indexPath.row].image)
            cell.nameLabel.isHidden = true
            cell.cardView.addBottomShadow()
            cell.nameLabel.textColor = CustomColor.uiColor(.tabTextColor)
            cell.cardView.backgroundColor = CustomColor.uiColor(.tabBGColor)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == selectedIndexPath{
            return CGSize(width: 150, height: 60)
        }
        else{
            let cellsAcross: CGFloat = 4
            let spaceBetweenCells: CGFloat = 5
            var width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells)
            width = (width - 155) / cellsAcross
            print(width)
            return CGSize(width: width, height: 45)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            add(compareVC, in: containerView)
        }
        else if indexPath.row == 1{
            add(infoVC, in: containerView)
        }
        else if indexPath.row == 2{
            add(reivewVC, in: containerView)
        }
        else if indexPath.row == 3{
            add(mapVC, in: containerView)
        }
        else if indexPath.row == 4{
            add(alertVC, in: containerView)
        }
//        scrollView.layoutIfNeeded()
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
}
