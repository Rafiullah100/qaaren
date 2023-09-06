//
//  Extensions.swift
//  News Hunt
//
//  Created by MacBook Pro on 7/27/23.
//

import Foundation
import UIKit
extension UIView {
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(named: "#084F24")?.cgColor ?? UIColor(), UIColor(named: "#327425")?.cgColor ?? UIColor()]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
    func showWithAnimation(delegate: UIViewController) {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            delegate.view.addSubview(self)
        }
    }
    
    func hideWithAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
    }
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
    }
    
    func edges(_ edges: UIRectEdge, to view: UIView, offset: UIEdgeInsets) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: offset.top).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.bottom).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.left).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.right).isActive = true
        }
    }
    
    func edges(_ edges: UIRectEdge, to layoutGuide: UILayoutGuide, offset: UIEdgeInsets) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: offset.top).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: offset.bottom).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: offset.left).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: offset.right).isActive = true
        }
    }
    
//    func addGradient() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.bounds
//        gradientLayer.colors = [UIColor(hex: "#327425"), UIColor(hex: "#084F24")]
//        self.layer.addSublayer(gradientLayer)
//    }
    
    func viewShadow(_ color: CustomColor? = .shadowColor) {
       layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
       layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
       layer.shadowOpacity = 0.5
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func removeShadow() {
            layer.shadowOffset = CGSize.zero
            layer.shadowColor = nil
            layer.shadowRadius = 0
            layer.shadowOpacity = 0
        }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}



extension UITableViewCell{
    class func cellReuseIdentifier() -> String {
        return "\(self)"
    }
}

extension UICollectionViewCell{
    class func cellReuseIdentifier() -> String {
        return "\(self)"
    }
}

extension UIViewController {
    

    
    func add(_ child: UIViewController, in container: UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
//        child.viewWillAppear(false)
    }
    
    func add(_ child: UIViewController) {
        add(child, in: view)
    }
    
    func remove(from view: UIView) {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func remove() {
        remove(from: view)
    }
}


extension UIWindow {
    static var key: UIWindow! {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
