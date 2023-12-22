//
//  SplashViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

import UIKit
import SwiftGifOrigin
class SplashViewController: UIViewController {
    var centerView: UIView?
    var centerIcon: UIView?
    let halfwayPoint = 120
    var isFlipped = false
    var isAnimating = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if Helper.isLogin() == true{
                Switcher.gotoHomeVC(delegate: self)
            }
            else{
                Switcher.gotoLoginVC(delegate: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIWindow.key.overrideUserInterfaceStyle = UserDefaults.standard.appTheme == AppTheme.dark.rawValue ? .dark : .light

        let imageView: UIImageView = view.viewWithTag(101) as! UIImageView
        imageView.image = UIImage.gif(name: "launch")
    }

    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            Switcher.gotoLoginVC(delegate: self)
//        }
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        centerView = view.viewWithTag(1)
//        centerIcon = view.viewWithTag(2)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//            self.centerView?.isHidden = true
//            self.moveIcon()
//        }
//    }
    
    func moveIcon() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseOut, animations: {
            self.centerIcon?.center.y -= CGFloat(self.halfwayPoint)
        }) { _ in
            self.makeBiggerAndRotate()
        }
    }
    
    func makeBiggerAndRotate() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.centerIcon?.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
            self.centerIcon?.transform = CGAffineTransform(rotationAngle: -(90)) // -135 degrees in radians
        }) { _ in
            self.makeCircle()
        }
    }
    
    func makeCircle() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.centerIcon?.frame.size = CGSize(width: 5, height: 5)
            self.centerIcon?.layer.cornerRadius = (self.centerIcon?.frame.height ?? 0) * 0.5
        }) { _ in
//            self.makeBiggerAndRotate()
        }
    }
}
