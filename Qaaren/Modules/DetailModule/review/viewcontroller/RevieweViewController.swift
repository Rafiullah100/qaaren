//
//  RevieweViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/1/23.
//

import UIKit

class RevieweViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.numberOfRows = 5
        tableView.cellHeight = 200.0
        tableView.estimatedRowHeight = 44.0
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.reviewList.bind { [unowned self] _ in
            self.tableView.reloadData()
        }
        viewModel.getReviewList(productID: productID ?? 0)
    }
    
    private func updateUI(){
        ratingLabel.text = LocalizationKeys.rating.rawValue.localizeString()
        ratingandReviewLabel.text = LocalizationKeys.ratingsAndReviews.rawValue.localizeString()
        addReviewButton.setTitle(LocalizationKeys.addReview.rawValue.localizeString(), for: .normal)
    }
    
    @IBAction func addReviewBtn(_ sender: Any) {
        Switcher.gotoAddReviewVC(delegate: self, productID: productID ?? 0)
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
        return 200.0
    }
}

extension RevieweViewController: AddReviewProtocol{
    func reviewAdded(review: AddReviewModel) {
        guard let addedReview = review.reviewData else { return }
        self.viewModel.reviewList.value?.insert(addedReview, at: 0)
    }
}
