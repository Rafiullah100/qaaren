//
//  RevieweViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/1/23.
//

import UIKit
import Toast_Swift
class RevieweViewController: UIViewController {

    @IBOutlet weak var oneStarLabel: UILabel!
    @IBOutlet weak var twoStarLabel: UILabel!
    @IBOutlet weak var threeStarLabel: UILabel!
    @IBOutlet weak var fourStarLabel: UILabel!
    @IBOutlet weak var fiveStarLabel: UILabel!
    @IBOutlet weak var ratingStarLabel: UILabel!
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingandReviewLabel: UILabel!
    @IBOutlet weak var tableView: AutoSizingUiTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.cellReuseIdentifier())
        }
    }
    var productID: Int?
    private var viewModel = ReviewViewModel()
    var totalReview: Int?
    var stars: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.reviewList.bind { [unowned self] _ in
            self.viewModel.getCount() == 0 ? self.tableView.setEmptyView() : self.tableView.reloadData()
            self.updateUI()
        }
        viewModel.getReviewList(productID: productID ?? 0)
    }
    
    private func updateUI(){
        oneStarLabel.text = "\(viewModel.getReviewStar(for: "1"))"
        twoStarLabel.text = "\(viewModel.getReviewStar(for: "1"))"
        threeStarLabel.text = "\(viewModel.getReviewStar(for: "3"))"
        fourStarLabel.text = "\(viewModel.getReviewStar(for: "4"))"
        fiveStarLabel.text = "\(viewModel.getReviewStar(for: "5"))"
        ratingLabel.text = LocalizationKeys.rating.rawValue.localizeString()
        ratingandReviewLabel.text = LocalizationKeys.ratingsAndReviews.rawValue.localizeString()
        addReviewButton.setTitle("+ \(LocalizationKeys.addReview.rawValue.localizeString())", for: .normal)
        ratingLabel.text = "\(totalReview ?? 0) \(LocalizationKeys.rating.rawValue.localizeString())"
        guard let rat = Float(stars ?? "0.0") else { return  }
        ratingStarLabel.text = String(format: "%.1f", rat)
    }
    
    @IBAction func addReviewBtn(_ sender: Any) {
        if Helper.isLogin() == true {
            Switcher.gotoAddReviewVC(delegate: self, productID: productID ?? 0)
        }
        else{
            self.view.makeToast("Login to comment")
        }
    }
}

extension RevieweViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellReuseIdentifier()) as! ReviewTableViewCell
        cell.review = viewModel.getReview(for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension RevieweViewController: AddReviewProtocol{
    func reviewAdded(review: AddReviewModel) {
        guard let addedReview = review.reviewData else { return }
        self.viewModel.reviewList.value?.insert(addedReview, at: 0)
    }
}
