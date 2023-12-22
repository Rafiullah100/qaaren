//
//  BaseViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/30/23.
//

//
//  BaseViewController.swift
//  News Hunt
//
//  Created by MacBook Pro on 7/27/23.
//

//
//  BaseViewController.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 06/12/21.
//

import UIKit
import SpinKit
enum ViewControllerType {
    case backWithTitle
    case detail
    case center
}



class BaseViewController: UIViewController, UINavigationControllerDelegate {
    let spinnerView = RTSpinKitView(style: .styleThreeBounce, color: CustomColor.appSecondryColor.color, spinnerSize: 70.0)


    var isOverlayViewAdded: Bool = false

    var type: ViewControllerType = .backWithTitle
    var titleLabel: UILabel?

    
    var viewControllerTitle: String? {
        didSet {
            titleLabel?.text = viewControllerTitle ?? ""
            switch type {
            case .detail, .center:
                addCenterLabel()
            default:
                break
            }
        }
    }
    
    func addCenterLabel() {

        
        titleLabel = UILabel()
        if let titleLabel = titleLabel {
            print(viewControllerTitle ?? "")
            titleLabel.text = viewControllerTitle ?? ""
            titleLabel.font = UIFont(name: Constants.fontNameBold, size: 17)
            titleLabel.textColor = .label
            self.navigationItem.titleView = titleLabel
        }
        
        
//        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 50, y: 0), size: CGSize(width: 50, height: 50)))
//        imageView.backgroundColor = .red
////        imageView.image = UIImage(named: "Search-blue")
////        imageView.contentMode = .scaleAspectFit
//        searchView.addSubview(imageView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let sideMenuViewController = SideMenuViewController()
//        let menu = SideMenuNavigationController(rootViewController: sideMenuViewController)
//        menu.statusBarEndAlpha = 0.5
//        SideMenuManager.default.leftMenuNavigationController = menu
//        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    func animateSpinner() {
        spinnerView?.center = view.center
        view.addSubview(spinnerView ?? UIView())
        spinnerView?.startAnimating()
    }
    
    func stopAnimation() {
        spinnerView?.stopAnimating()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        solidNavigationBar()
        switch type {
        case .backWithTitle:
            setupBackButtonWithTitle()
        case .detail:
            setupDetailButtons()
        case .center:
            print("")
        }
    }
    
    func solidNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
       if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
           appearance.backgroundColor = type == .backWithTitle ? CustomColor.navigationColor.color : .clear
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
           navigationController?.navigationBar.frame = CGRect(x: navigationController?.navigationBar.frame.origin.x ?? 0, y: navigationController?.navigationBar.frame.origin.y ?? 0, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
           //y = 20
        }else{
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.frame = CGRect(x: navigationController?.navigationBar.frame.origin.x ?? 0, y: navigationController?.navigationBar.frame.origin.y ?? 0, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
        }
    }
    
    func setupHomeBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        navigationItem.rightBarButtonItems = []
    }
    
    func setupBackButtonWithTitle() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addBackButtonWithTitle()
    }
    
    func setupHomeButtons() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
//        addHomeButtons()
        addCenterLabel()
    }
    
    func setupDetailButtons() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addDetailButtons()
    }
    
    func addDetailButtons() {
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        leftButton.image = UIImage(named: "back-arrow")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = leftButton
    }

    
    func addArrowBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        backButton.image = nil
        backButton.image = UIImage(named: "back-arrow")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func addBackButtonWithTitle() {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 35))
        imageView.contentMode = .scaleAspectFit
//        imageView.image = viewControllerTitle == "" ? #imageLiteral(resourceName: "back-arrow") : UIImage(named: "arrow-black")
        
        imageView.image = UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue ? UIImage(named: "arrow-black-rtl") : UIImage(named: "arrow-black-ltr")
        let labelbgView = UIView(frame: CGRect(x: 35, y: 0, width: UIScreen.main.bounds.width, height: 30))
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: UIScreen.main.bounds.width, height: 30))
        label.textColor = .label
        labelbgView.addSubview(label)
        let stringArray = viewControllerTitle?.split(separator: "|")
        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "\(Constants.fontNameBold)", size: 18) ?? UIFont()]
        let secondAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "\(String(describing: Constants.fontNameBold))", size: 18) ?? UIFont()]
        let firstString = NSMutableAttributedString(string: String("\(stringArray?[0].prefix(80) ?? "")"), attributes: firstAttributes)
        var secondString = NSAttributedString("")
        if stringArray?.count ?? 0 > 1{
            secondString = NSAttributedString(string: String("| \(stringArray?[1] ?? "")"), attributes: secondAttributes)
        }
        firstString.append(secondString)

        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        button.frame = buttonView.frame
        buttonView.addSubview(button)
        buttonView.addSubview(imageView)
        buttonView.addSubview(labelbgView)
        buttonView.backgroundColor = .red
        let barButton = UIBarButtonItem.init(customView: buttonView)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backButtonAction() {
        if let _ = navigationController?.popViewController(animated: true) {
        } else {
            navigationController?.tabBarController?.selectedIndex = 0
            dismiss(animated: true, completion: nil)
        }
    }
    
//    @objc func filterAction() {
//        searchView.isHidden.toggle()
//        titleLabel?.isHidden.toggle()
//
//        if self.navigationItem.titleView == searchView{
//            self.navigationItem.titleView = titleLabel
//        }
//        else{
//            self.navigationItem.titleView = searchView
//        }
//    }
    
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backAction() {
        if let _ = navigationController?.popViewController(animated: true) {
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}
