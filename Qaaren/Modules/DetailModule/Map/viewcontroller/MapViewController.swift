//
//  MapViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/4/23.
//

import UIKit
import GoogleMaps
class MapViewController: BaseViewController {

    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 6.0)
        mapView.camera = camera
    }
    @IBAction func mapButton(_ sender: Any) {
        Switcher.gotoFullScreenMsp(delegate: self)
    }
}
