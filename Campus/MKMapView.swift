//
//  MKMapView.swift
//  Campus
//
//  Created by Matt Hansen on 4/24/18.
//  Copyright © 2018 The Pennsylvania State University. All rights reserved.
//

import GEOSwift
import MapKit
import CoreLocation

extension ViewController: MKMapViewDelegate {
    
    // Addd Building Polygons
    func loadBuildings() {
        if let geoJSONURL = Bundle.main.url(forResource: "PSU_OPP_Buildings201710", withExtension: "geojson") {
            do {
                let features = try! Features.fromGeoJSON(geoJSONURL)
                
                for feature in features! {
                    if let polygon = feature.geometries?.first?.mapShape() as? MKPolygon {
                        
                        //let buildingName = feature.properties?["BLDG_NAME"] ?? "Unknown"
                        if let bldgName = feature.properties?["BLDG_NAME"] as? String,
                            let bldgNumStr = feature.properties?["BLDG_NUM"] as? String, let bldgNum = Int(bldgNumStr){
                            
                            //let building = Building(number: bldgNum, name: bldgName, coordinate: polygon.coordinate)
                            
                            // MKPolygon MKOverlay Contains Tap???
                            //mapView.addAnnotation(building)
                            //mapView.addAnnotation(polygon)
                        }
                        mapView.add(polygon)
                    }
                }
            }
        }
    }
    
    // Add Historical Marker Annotations
    func loadMarkers() {
        if let jsonURL = Bundle.main.url(forResource: "HistoricalMarkers", withExtension: "json") {
            do {
                let features = try! Features.fromGeoJSON(jsonURL)
                
                for feature in features! {
                    if let point = feature.geometries?.first?.mapShape() as? MKPointAnnotation {
                        
                        let properties = feature.properties!
                        let marker = Marker(index:  properties["index"] as! Int,
                                            title:  properties["title"] as! String,
                                            brief:  properties["brief"] as! String,
                                            detail: properties["detail"] as! String,
                            coordinate: point.coordinate)
                        
                        mapView.addAnnotation(marker)
                    }
                }
            }
        }
    }
    
    // Center Location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // Polygon Overlay
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.psuBlue
        renderer.fillColor = UIColor.psuBlue
        renderer.lineWidth = 0.5
        renderer.alpha = 0.25
        
        return renderer
    }
    
    //@objc func mapTapped(_ tap: UITapGestureRecognizer) {
    //    print("mapTapped", tap.location(in: mapView))
    //}
    
    // Tapped annotation info button
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let marker = view.annotation as! Marker
        print("calloutAccessoryControlTapped", marker.index)
        
        //self.performSegue(withIdentifier: "PlaceDetails", sender: self)
        self.performSegue(withIdentifier: "PlaceDetails", sender: marker)
    }
    
    // Tapped annotation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let marker = view.annotation as? Marker {
            print("didSelect", marker.index)
        } else {
            print(view.annotation as Any)
        }
    }
    
    // Marker annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil // Draws default "blue dot" for user location
        }
        
        if annotation is Building {
            return nil
        }
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView!.canShowCallout = true
            pinView!.image = #imageLiteral(resourceName: "logo")
            
            
            let calloutButton = UIButton(type: .detailDisclosure)
            pinView!.rightCalloutAccessoryView = calloutButton
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
}

// MKPolygon Contains Extension
extension MKPolygon {
    func contains(coor: CLLocationCoordinate2D) -> Bool {
        let polygonRenderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint: MKMapPoint = MKMapPointForCoordinate(coor)
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
        return polygonRenderer.path.contains(polygonViewPoint)
    }
}

// UIColor Extension
extension UIColor {
    static let psuBlue = UIColor.init(red: 0/255, green: 45/255, blue: 97/255, alpha: 1.0)
}
