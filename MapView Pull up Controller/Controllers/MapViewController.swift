//
//  ViewController.swift
//  MapView Pull up Controller
//
//  Created by Viswa Kodela on 6/20/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK:- init
    
    // MARK:- Properties
    var locationManager: CLLocationManager?
    
    // MARK:- Views
    var mapView: MKMapView!
    var searchInputView: SearchInputView!

    //MARK: - Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapview()
        configureLocationServices()
        configureSearchInputView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        centerMapOnUserLocation()
    }
    
    // MARK:- Helper Methods
    
    fileprivate func configureMapview() {
        
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureSearchInputView() {
        self.searchInputView = SearchInputView()
        searchInputView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchInputView)
        searchInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (view.frame.height - 88)).isActive = true
        searchInputView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
    
    func configureLocationServices() {
        
        self.locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    func centerMapOnUserLocation() {
        guard let coordinates = locationManager?.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}


// MARK:-  Location Manager Delegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .notDetermined:
            print("Location status NOT DETERMINED")
            
            DispatchQueue.main.async {
                let locationRequestController = LocationRequestController()
                locationRequestController.locationManager = self.locationManager
                self.present(locationRequestController, animated: true, completion: nil)
            }
        case .restricted:
            print("Location status RESTRICTED")
        case .denied:
            print("Location status DENIED")
        case .authorizedAlways:
            print("Location status AUTHERIZED ALWAYS")
        case .authorizedWhenInUse:
            print("Location status AUTHORIZED WHEN IN USE")
        @unknown default:
            print("Location status DEFAULT")
        }
    }
}

