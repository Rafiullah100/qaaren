//
//  ProfileViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/7/23.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: ProfileTableViewCell.cellReuseIdentifier())
        }
    }
    
    let arr = [LocalizationKeys.personalInformation.rawValue.localizeString(), LocalizationKeys.mySources.rawValue.localizeString(), LocalizationKeys.myCategories.rawValue.localizeString(), LocalizationKeys.wishlist.rawValue.localizeString()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateUI(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.cellReuseIdentifier()) as! ProfileTableViewCell
        cell.titleLabel.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.nameLabell.text = UserDefaults.standard.name
        headerView.usernameLabel.text = UserDefaults.standard.email
        headerView.imageView.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
        headerView.imageView.layer.cornerRadius = headerView.imageView.frame.height * 0.5
        headerView.imageView.layer.masksToBounds = true
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 210.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            Switcher.gotoInformation(delegate: self)
        }
        else if indexPath.row == 1{
            Switcher.gotoMySources(delegate: self)
        }
        else if indexPath.row == 2{
            Switcher.gotoMyCategory(delegate: self)
        }
        else if indexPath.row == 3{
            Switcher.gotoWishlist(delegate: self)
        }
    }
}