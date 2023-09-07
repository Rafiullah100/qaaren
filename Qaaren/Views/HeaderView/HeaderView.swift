//
//  HeaderView.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/7/23.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var nameView: UIView!
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
        addSubview(headerView)
    }

}
