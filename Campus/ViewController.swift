//
//  ViewController.swift
//  Campus
//
//  Created by Matt Hansen on 12/21/17.
//  Copyright © 2017 The Pennsylvania State University. All rights reserved.
//

import UIKit
import GEOSwift
import MapKit
import CoreLocation
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var zoomToObeliskBtn: UIBarButtonItem!
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        mapView.delegate = self
        super.viewDidLoad()
        
        //let mapTap = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
        //mapView.addGestureRecognizer(mapTap)
        
        mapView.showsPointsOfInterest = false
        mapView.showsTraffic = false
        
        mapView.showsScale = true
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsBuildings = true
        
        // Add button to zoom to user location
        let myLocationBtn = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = myLocationBtn
        
        zoomToObelisk(self)
        loadBuildings()
        loadMarkers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    @IBAction func zoomToObelisk(_ sender: Any) {
        // Set initial location - 40.795497, -77.863350 - Obelisk
        let initialLocation = CLLocation(latitude: 40.795497, longitude: -77.863350)
        centerMapOnLocation(location: initialLocation)
    }
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        mapView.mapType = MKMapType.init(rawValue: UInt(sender.selectedSegmentIndex)) ?? .standard
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("ViewController: prepare for segue", segue, sender!)

        if let destination = segue.destination as? PlaceDetailsViewController {
            let marker = sender as! Marker
            destination.detailTitle = marker.name
            destination.detailImage = UIImage.animatedImage(with: destination.markerImages[marker.index]!, duration: 5.0)
            destination.detailText = marker.detail

        }
    }
}

