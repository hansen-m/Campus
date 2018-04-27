//
//  Building.swift
//  Campus
//
//  Created by Matt Hansen on 12/27/17.
//  Copyright © 2017 The Pennsylvania State University. All rights reserved.
//

import Foundation
import MapKit

class Building: NSObject, MKAnnotation {
    let number: Int
    let name: String
    let coordinate: CLLocationCoordinate2D
    
    init(number: Int, name: String, coordinate: CLLocationCoordinate2D) {
        self.number = number
        self.name = name
        self.coordinate = coordinate
        
        super.init()
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return String(number)
    }

}
