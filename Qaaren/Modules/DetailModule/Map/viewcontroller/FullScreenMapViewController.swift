//
//  FullScreenMapViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/4/23.
//

import UIKit
import GoogleMaps
class FullScreenMapViewController: BaseViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text = LocalizationKeys.nearestLocation.rawValue.localizeString()
        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 6.0)
        mapView.camera = camera
        
        let position = CLLocationCoordinate2DMake(34.0151,71.5249)
        let marker = GMSMarker(position: position)
        marker.map = mapView
    }
    
    @IBAction func backBtnActio(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
