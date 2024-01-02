//
//  SplashViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

import UIKit
import SwiftGifOrigin
class SplashViewController: UIViewController {
    var centerIconView: UIView?
    var label: UILabel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIWindow.key.overrideUserInterfaceStyle = UserDefaults.standard.appTheme == AppTheme.dark.rawValue ? .dark : .light
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            Helper.isLogin() == true ? Switcher.gotoHomeVC(delegate: self) : Switcher.gotoLoginVC(delegate: self)
        }
        
        centerIconView = view.viewWithTag(1)
        label = view.viewWithTag(2) as? UILabel
        self.startAnimatingIcon()
    }
    
    func startAnimatingIcon() {
        centerIconView?.isHidden = false
        let halfwayPoint = 200
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.centerIconView?.center.y -= CGFloat(halfwayPoint)
        }) { _ in
            self.scaleupAndrotateIcon()
        }
    }
    
    func scaleupAndrotateIcon() {
        UIView.animate(withDuration: 1.0, animations: {
            self.centerIconView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.centerIconView?.transform = self.centerIconView?.transform.rotated(by: -.pi * 3 / 4) ?? CGAffineTransform()
        }, completion: { _ in
            self.againScaleUpWithRoundedCorner()
        })
    }
    
    func againScaleUpWithRoundedCorner() {
        UIView.animate(withDuration: 1.0, animations: {
            self.centerIconView?.transform = CGAffineTransform(rotationAngle:  -.pi * 3 / 4).scaledBy(x: 0.4, y: 0.4)

        }, completion: { _ in
            self.centerIconView?.layer.cornerRadius = 0
            self.spreadImage()
        })
    }
    
    
    func spreadImage() {
        UIView.animate(withDuration: 1.0, animations: {
            self.centerIconView?.transform = CGAffineTransform(rotationAngle: .pi).scaledBy(x: 5, y: 10)
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
//                self.label?.isHidden = false
            })
        })
    }
}
