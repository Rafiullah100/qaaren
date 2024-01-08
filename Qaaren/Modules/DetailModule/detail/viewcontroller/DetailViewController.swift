//
//  DetailViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

import UIKit
import SDWebImage
class DetailViewController: BaseViewController {
    @IBOutlet weak var collapsableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet var sliderImagesContainer: [UIView]!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
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
    var headerViewMaxHeight = 300.0
    var headerViewMinHeight = 0.0
    var isScrollViewAtBottom = false
    
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
        type = .detail
        viewControllerTitle = "Details"
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: self.view.safeAreaLayoutGuide.layoutFrame.height)
    }
        
    private func updateUI(){
        addVCToContainer()
        print(viewModel.getTitle())
        nameLabel.text = viewModel.getTitle()
        priceRangeLabel.text = LocalizationKeys.priceRange.rawValue.localizeString()
        amountLabel.text = "590 - 882 \(LocalizationKeys.sar.rawValue.localizeString())"
        headerImageView.sd_setImage(with: URL(string: viewModel.getImages(0)), placeholderImage: UIImage(named: "placeholder"))
        favoriteIcon.image = UIImage(named: viewModel.isWishlisted() == true ? "favorite_red" : "favorite_gray")
        for (index, imgView) in imageViews.enumerated() {
            imgView.sd_setImage(with: URL(string: viewModel.getImages(index)), placeholderImage: UIImage(named: "placeholder"))
        }
        rearrangeImages(imagesCount: viewModel.getImageCount())
        guard let rat = Float(viewModel.getTotalStars()) else { return  }
        ratingLabel.text = String(format: "%.1f", rat)
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
            compareVC.tableView.isScrollEnabled = isScrollViewAtBottom
            compareVC.view.frame = containerView.bounds
            containerView.addSubview(compareVC.view)
            compareVC.didMove(toParent: self)
        case 1:
            addChild(infoVC)
            self.add(infoVC, in: containerView)
            infoVC.descriptionText = viewModel.getDescription()
            infoVC.textView.isScrollEnabled = isScrollViewAtBottom
            infoVC.view.frame = containerView.bounds
            containerView.addSubview(infoVC.view)
            infoVC.didMove(toParent: self)
        case 2:
            addChild(ratingVC)
            self.add(ratingVC, in: containerView)
            ratingVC.productID = productID
            ratingVC.totalReview = viewModel.getTotalReviews()
            ratingVC.tableView.isScrollEnabled = isScrollViewAtBottom
            ratingVC.stars = viewModel.getTotalStars()
            ratingVC.view.frame = containerView.bounds
            containerView.addSubview(ratingVC.view)
            ratingVC.didMove(toParent: self)
        case 3:
            addChild(mapVC)
            self.add(mapVC, in: containerView)
            mapVC.nearestCoordinates = viewModel.getNearestCoordinates()
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
        print(index)
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

extension DetailViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.frame.height
        guard let headerViewHeightConstraint = collapsableViewHeight else {return}
        let newHeaderViewHeight: CGFloat =
        headerViewHeightConstraint.constant - y
        if newHeaderViewHeight > headerViewMaxHeight {
            headerViewHeightConstraint.constant = headerViewMaxHeight
        } else if newHeaderViewHeight <= headerViewMinHeight {
            headerViewHeightConstraint.constant = headerViewMinHeight
        } else {
            headerViewHeightConstraint.constant = newHeaderViewHeight
        }
        if y + scrollViewHeight >= scrollView.contentSize.height {
            isScrollViewAtBottom = true
            enableScrolling()
        }
        
        guard let navigationBarHeight = navigationController?.navigationBar.frame.height else { return }
        if newHeaderViewHeight < navigationBarHeight{
            solidNavigationBar(color: .white)
            addDetailButtons(isWhite: false)
        }
        else{
            solidNavigationBar(color: .clear)
            addDetailButtons(isWhite: true)
        }
    }
    
    func enableScrolling() {
        switch selectedIndexPath?.row {
        case 0:
            compareVC.tableView.isScrollEnabled = true
        case 1:
            infoVC.textView.isScrollEnabled = true
        case 2:
            ratingVC.tableView.isScrollEnabled = true
        default:
            break
        }
    }
}

