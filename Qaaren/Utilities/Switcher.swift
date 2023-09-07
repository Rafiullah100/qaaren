//
//  Switcher.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//


import Foundation
import UIKit

class Switcher {
    
    static func gotoLoginVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoHomeVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        vc.selectedIndex = 2
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoFilterVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.filter.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        delegate.present(vc, animated: true, completion: nil)
    }
    
    static func gotoDetailVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        vc.tabBarController?.tabBar.isHidden = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoFullScreenMsp(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FullScreenMapViewController") as! FullScreenMapViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoWishlist(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlisViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoInformation(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "InformationViewController") as! InformationViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
}
    


