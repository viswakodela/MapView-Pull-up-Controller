//
//  LocationRequestController.swift
//  MapView Pull up Controller
//
//  Created by Viswa Kodela on 6/20/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import CoreLocation

class LocationRequestController: UIViewController {
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    var locationImageView: UIImageView!
    var allowLocationLabel: UILabel!
    var enableLocationLabel: UILabel!
    var enableButton: UIButton!
    
    fileprivate func configureViews() {
        view.backgroundColor = .white
        locationImageView = UIImageView(image: #imageLiteral(resourceName: "tag-1873545_1280"))
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.contentMode = .scaleAspectFit
        locationImageView.clipsToBounds = true
        
        allowLocationLabel = UILabel()
        allowLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        allowLocationLabel.text = "Allow Location"
        allowLocationLabel.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        allowLocationLabel.textAlignment = .center
        
        enableLocationLabel = UILabel()
        enableLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        enableLocationLabel.textAlignment = .center
        enableLocationLabel.text = "Please enable location services, so that we can track your location movements"
        enableLocationLabel.numberOfLines = 2
        enableLocationLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        enableButton = UIButton()
        enableButton.translatesAutoresizingMaskIntoConstraints = false
        enableButton.setTitle("Enable Location", for: .normal)
        enableButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        enableButton.setTitleColor(.white, for: .normal)
        enableButton.layer.cornerRadius = 8
        enableButton.addTarget(self, action: #selector(handleEnableLocation), for: .touchUpInside)
        
        let overallStackView = UIStackView(arrangedSubviews: [locationImageView,
                                                              allowLocationLabel,
                                                              enableLocationLabel,
                                                              enableButton])
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.axis = .vertical
        overallStackView.spacing = 5
        
        locationImageView.heightAnchor.constraint(equalTo: overallStackView.heightAnchor, multiplier: 0.5).isActive = true
        
        
        view.addSubview(overallStackView)
        
        overallStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    @objc func handleEnableLocation() {
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.delegate = self
    }
}

extension LocationRequestController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard self.locationManager?.location != nil else {
            return
        }
        dismiss(animated: true, completion: nil)
    }
}
