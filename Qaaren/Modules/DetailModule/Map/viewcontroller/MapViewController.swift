//
//  MapViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/4/23.
//

import UIKit
import GoogleMaps
class MapViewController: BaseViewController {

    @IBOutlet weak var viewLabel: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var latitude: String?
    var longitude: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewLabel.setTitle(LocalizationKeys.viewFull.rawValue.localizeString(), for: .normal)
        locationLabel.text = LocalizationKeys.nearestLocation.rawValue.localizeString()
        
        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 6.0)
        mapView.camera = camera
        let position = CLLocationCoordinate2DMake(34.0151,71.5249)
        let marker = GMSMarker(position: position)
        marker.map = mapView
    }
    
    @IBAction func mapButton(_ sender: Any) {
        Switcher.gotoFullScreenMsp(delegate: self)
    }
}
