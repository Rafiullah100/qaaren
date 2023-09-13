//
//  DetailViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

import UIKit

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet var sliderImagesContainer: [UIView]!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "TabCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TabCollectionViewCell.cellReuseIdentifier())
        }
    }
    var selectedIndexPath: IndexPath?
    let viewModel = DetailViewModel()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        containerViews.first?.isHidden = false
        type = .detail
        selectedIndexPath = IndexPath(row: 0, section: 0)
        sliderImages(index: 0)
        switchTab(selectedTab: selectedIndexPath?.row ?? 0)
    }
    
    private func updateUI(){
        priceRangeLabel.text = LocalizationKeys.priceRange.rawValue.localizeString()
        amountLabel.text = "590 - 882 \(LocalizationKeys.sar.rawValue.localizeString())"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        viewModel.viewControllers.forEach { vc in
            if let childViewController = segue.destination as? UIViewController {
                childViewController.view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
    
    @IBAction func image1Button(_ sender: Any) {
        sliderImages(index: 0)
    }
    
    @IBAction func image2Button(_ sender: Any) {
        sliderImages(index: 1)
    }
    
    @IBAction func image3Button(_ sender: Any) {
        sliderImages(index: 2)
    }
    
    @IBAction func image4Button(_ sender: Any) {
        sliderImages(index: 3)
    }
    
    func switchTab(selectedTab: Int){
        for (index, view) in containerViews.enumerated(){
            view.isHidden = selectedTab == index ? false : true
        }
    }
    
    func sliderImages(index: Int) {
        headerImageView.image = imageViews[index].image
        for (i, view) in sliderImagesContainer.enumerated(){
            view.layer.borderColor = i == index ? UIColor.green.cgColor : UIColor.clear.cgColor
        }
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
            return Helper.cellSize(noOfCells: 4, space: 5, collectionView: collectionView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switchTab(selectedTab: indexPath.row)
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
}
