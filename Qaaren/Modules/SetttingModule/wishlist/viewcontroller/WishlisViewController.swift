//
//  WishlistViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/5/23.
//

import UIKit

class WishlisViewController: BaseViewController {


    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: HomeTableViewCell.cellReuseIdentifier())
        }
    }
    var viewModel = MyWishlistViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        viewControllerTitle = LocalizationKeys.wishlist.rawValue.localizeString()
        self.animateSpinner()
        viewModel.myWishlist.bind { _ in
            DispatchQueue.main.async {
                self.stopAnimation()
                self.tableView.reloadData()
            }
        }
        viewModel.getWishlist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension WishlisViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellReuseIdentifier()) as! HomeTableViewCell
        cell.type = .favorite
        guard let cat = viewModel.getSingleCategory(at: indexPath.row) else { return cell }
        cell.wishlistCategory = cat
        cell.didTappedProduct = { productID in
            print(productID)
            Switcher.gotoDetailVC(delegate: self, productID: productID)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360.0
    }
}


