//
//  FullScreenMapViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/4/23.
//

import UIKit
import GoogleMaps
class FullScreenMapViewController: BaseViewController {

    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true
        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 6.0)
        mapView.camera = camera
    }
    @IBAction func backBtnActio(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
