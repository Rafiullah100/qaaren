//
//  HeaderView.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/7/23.
//

import UIKit
enum ImageSource {
    case photoLibrary
    case camera
}
class HeaderView: UIView {

    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var logoutButtonView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabell: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var nameView: UIView!
    
    var didTappedCamera: (() -> Void)? = nil
    var logout: (() -> Void)? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }

    private func commoninit(){
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)![0] as! UIView
        headerView.frame = self.bounds
        headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        logoutLabel.text = LocalizationKeys.logout.rawValue.localizeString()
        addSubview(headerView)
    }

    @IBAction func cameraBtnAction(_ sender: Any) {
        didTappedCamera?()
    }
    @IBAction func logoutBtnAction(_ sender: Any) {
        logout?()
    }
}
