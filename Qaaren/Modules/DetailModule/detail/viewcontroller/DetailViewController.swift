//
//  DetailViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

import UIKit
import SDWebImage
class DetailViewController: BaseViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet var sliderImagesContainer: [UIView]!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "TabCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TabCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var containerView: UIStackView!
    
    @IBOutlet weak var favoriteIcon: UIImageView!
    private var selectedIndexPath: IndexPath?
    private var viewModel = DetailViewModel()
    var productID: Int?
    
    lazy var compareVC: CompareeViewController = {
        return UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompareeViewController") as! CompareeViewController
    }()
    
    lazy var infoVC: InfoViewController = {
        return UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
    }()
    
    lazy var ratingVC: RevieweViewController = {
        return UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "RevieweViewController") as!  RevieweViewController
    }()
    
    lazy var mapVC: MapViewController = {
        return UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
    }()
    
    lazy var alertVC: AlertViewController = {
        return UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(productID ?? 0)
        type = .detail
        self.animateSpinner()
        viewModel.getDetail(productID: productID ?? 0)
        bindProductDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.addView(productID: productID ?? 0)
    }
    
    private func bindProductDetail(){
        viewModel.productDetail.bind { [unowned self] _ in
            self.stopAnimation()
            updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        selectedIndexPath = IndexPath(row: 0, section: 0)
        sliderImages(index: 0)
    }
    
    private func updateUI(){
        addVCToContainer()
        print(viewModel.getTitle())
        ratingLabel.text = "\(viewModel.getRating())"
        nameLabel.text = viewModel.getTitle()
        priceRangeLabel.text = LocalizationKeys.priceRange.rawValue.localizeString()
        amountLabel.text = "590 - 882 \(LocalizationKeys.sar.rawValue.localizeString())"
        headerImageView.sd_setImage(with: URL(string: viewModel.getImages(0)), placeholderImage: UIImage(named: "placeholder"))
        favoriteIcon.image = UIImage(named: viewModel.isWishlisted() == true ? "favorite_red" : "favorite_gray")
        for (index, imgView) in imageViews.enumerated() {
            imgView.sd_setImage(with: URL(string: viewModel.getImages(index)), placeholderImage: UIImage(named: "placeholder"))
        }
        rearrangeImages(imagesCount: viewModel.getImageCount())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        viewModel.viewControllers.forEach { vc in
//            if let childViewController = segue.destination as? UIViewController {
//                childViewController.view.translatesAutoresizingMaskIntoConstraints = false
//            }
//        }
    }
    
    @IBAction func sliderButtonsAction(_ sender: UIButton) {
        let index = sender.tag
        sliderImages(index: index)
    }
    
    func addVCToContainer() {
        switch selectedIndexPath?.row {
        case 0:
            addChild(compareVC)
            self.add(compareVC, in: containerView)
            compareVC.compareProductList = viewModel.getComparisonItems()
            compareVC.view.frame = containerView.bounds
            containerView.addSubview(compareVC.view)
            compareVC.didMove(toParent: self)
        case 1:
            addChild(infoVC)
            self.add(infoVC, in: containerView)
//            infoVC.descriptionText = viewModel.get
            infoVC.view.frame = containerView.bounds
            containerView.addSubview(infoVC.view)
            infoVC.didMove(toParent: self)
        case 2:
            addChild(ratingVC)
            self.add(ratingVC, in: containerView)
            ratingVC.productID = productID
            compareVC.view.frame = containerView.bounds
            containerView.addSubview(ratingVC.view)
            ratingVC.didMove(toParent: self)
        case 3:
            addChild(mapVC)
            self.add(mapVC, in: containerView)
            mapVC.view.frame = containerView.bounds
            containerView.addSubview(mapVC.view)
            mapVC.didMove(toParent: self)
        case 4:
            addChild(alertVC)
            self.add(alertVC, in: containerView)
            alertVC.productID = productID
            alertVC.view.frame = containerView.bounds
            containerView.addSubview(alertVC.view)
            alertVC.didMove(toParent: self)
        default:
            self.add(compareVC, in: containerView)
        }
        
    }
    
    func sliderImages(index: Int) {
        headerImageView.image = imageViews[index].image
        for (i, view) in sliderImagesContainer.enumerated(){
            view.layer.borderColor = i == index ? UIColor.green.cgColor : UIColor.clear.cgColor
        }
    }
    
    private func rearrangeImages(imagesCount: Int){
        print(imagesCount)
        for (i, view) in sliderImagesContainer.enumerated(){
            view.isHidden = i < imagesCount ? false : true
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
        selectedIndexPath = indexPath
        addVCToContainer()
        collectionView.reloadData()
    }
}
