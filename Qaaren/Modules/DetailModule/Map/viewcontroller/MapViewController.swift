//
//  MapViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/4/23.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController {

    @IBOutlet weak var viewLabel: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var latitude: String?
    var longitude: String?
    var nearestCoordinates: [NearestCoordinates]?{
        didSet{
            setupMap()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupMap(){
        print(nearestCoordinates ?? [])
        viewLabel.setTitle(LocalizationKeys.viewFull.rawValue.localizeString(), for: .normal)
        locationLabel.text = LocalizationKeys.nearestLocation.rawValue.localizeString()
        let camera = nearestCoordinates?.count == 0 ? GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 6.0) : GMSCameraPosition.camera(withLatitude: nearestCoordinates?.first?.latidtude ?? 0.0, longitude: nearestCoordinates?.first?.longitude ?? 0.0, zoom: 9.0)
        mapView.camera = camera
        nearestCoordinates?.forEach({ nearest in
            let position = CLLocationCoordinate2D(latitude: nearest.latidtude ?? 0.0, longitude: nearest.longitude ?? 0.0)
            let marker = GMSMarker(position: position)
            marker.map = mapView
            marker.icon = UIImage(named: "marker")
        })
    }
    
    @IBAction func mapButton(_ sender: Any) {
        Switcher.gotoFullScreenMap(delegate: self, coordinates: nearestCoordinates ?? [])
    }
}
