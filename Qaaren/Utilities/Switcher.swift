//
//  Switcher.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//


import Foundation
import UIKit

class Switcher {
    static func logout(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        delegate.navigationController?.pushViewController(vc, animated: false)
//        delegate.present(vc, animated: true)
    }
    
    static func gotoLoginVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoHomeVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        vc.selectedIndex = 2
        UIWindow.key.rootViewController = vc
        UIWindow.key.makeKeyAndVisible()
    }
    
    static func gotoFilterVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.popUp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        delegate.present(vc, animated: true, completion: nil)
    }
    
    static func gotoAddReviewVC(delegate: UIViewController, productID: Int){
        let vc = UIStoryboard(name: Storyboard.popUp.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddReviewViewController") as! AddReviewViewController
        vc.delegate = delegate as? any AddReviewProtocol
        vc.productID = productID
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        delegate.present(vc, animated: true, completion: nil)
    }
    
    static func gotoDetailVC(delegate: UIViewController, productID: Int){
        print(productID)
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.productID = productID
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        vc.tabBarController?.tabBar.isHidden = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoFullScreenMap(delegate: UIViewController, coordinates: [NearestCoordinates]){
        let vc = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FullScreenMapViewController") as! FullScreenMapViewController
        vc.nearestCoordinates = coordinates
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoWishlist(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlisViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoLanguage(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAboutScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoPrivacyScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PrivacyViewController") as! PrivacyViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoInformation(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "InformationViewController") as! InformationViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    static func gotoMyCategory(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MyCategoryViewController") as! MyCategoryViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    static func gotoMySources(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MySourcesViewController") as! MySourcesViewController
//        vc.hidesBottomBarWhenPushed = false
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoOtpScreen(delegate: UIViewController, email: String){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
//        vc.hidesBottomBarWhenPushed = false
        vc.email = email
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoViewAllScreen(delegate: UIViewController, productID: Int){
        print(productID)
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ViewAllViewController") as! ViewAllViewController
        vc.productID = productID
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        vc.tabBarController?.tabBar.isHidden = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
}
    


