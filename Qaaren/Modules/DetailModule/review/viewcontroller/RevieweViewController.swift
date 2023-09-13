//
//  RevieweViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/1/23.
//

import UIKit

class RevieweViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.numberOfRows = 5
        tableView.cellHeight = 200.0
        tableView.estimatedRowHeight = 44.0
        updateUI()
    }
    
    private func updateUI(){
        
        ratingLabel.text = LocalizationKeys.rating.rawValue.localizeString()
        ratingandReviewLabel.text = LocalizationKeys.ratingsAndReviews.rawValue.localizeString()
        addReviewButton.setTitle(LocalizationKeys.addReview.rawValue.localizeString(), for: .normal)
    }
    
    @IBAction func addReviewBtn(_ sender: Any) {
        Switcher.gotoAddReviewVC(delegate: self)
    }
}


extension RevieweViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellReuseIdentifier()) as! ReviewTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
