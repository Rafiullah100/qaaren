//
//  Constants.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import Foundation
import UIKit
import Firebase
struct HowTo {
    let text1: String?
    let text2: String?
    let image: String?
}


struct Constants {
    static var clientID = FirebaseApp.app()?.options.clientID

    static let appColor = #colorLiteral(red: 0.9682764411, green: 0.6770070195, blue: 0.4894526005, alpha: 1)
    static let fontName = "manrope"
    static let fontNameBold = "manrope-Bold"
    static let fontRegular = "manrope-Regular"
    static let fontNameMedium = "manrope-Medium"
    static let fontNameSemoBold = "manrope-Semibold"

    static let appMediumFont = UIFont(name: "manrope-Medium", size: 10.0)

    static let appBoldFont = UIFont(name: "manrope-bold", size: 12.0)
    static let appRegularFont = UIFont(name: "manrope", size: 12.0)
    static let errorMessage = "Something went wrong!"
    static let newsSection = ["Latest", "Politics", "Financial", "Sports", "SciTech", "Entertainment", "Health", "Tourism", "Blend"]
    
    static let opanionSection = ["Hasan Nisar", "Hamid Mir", "Aftab Iqbal", "Hasan Nisar", "Hasan Nisar"]
    
    static let source = [ "• haraj.com.sa.",
   "• Noon.com.",
   "• aliexpress.com.",
   "• amazon.sa",
   "• opensooq.com.",
   "• Jarir",
   "• Extra.com",
   "• Alshaya",
   "• Eddy",
   "• Nahdionline.com",
   "• Namshi.com.",
   "• Mercado Libre",
   "• Amazon.ae",
   "• Jazp",
   "• Ebay",
   "• Walmart",
   "• Target Corporation",
   "• Best Buy",
   "• Rakuten",
   "• Newegg",
   "• Carrefour",
   "• Cobone",
   "• Lulu Hypermarket",
   "• Ounass",
   "• Tamimi Markets",
   "• Ubuy",
   "• Xcite",
   "• Extrastores.com",
   "• Alibaba.com",
   "• Markavip.com",
    ]
    
    static let rtl = 1
    static let ltr = 0
}
