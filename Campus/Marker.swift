//
//  Marker.swift
//  Campus
//
//  Created by Matt Hansen on 4/4/18.
//  Copyright © 2018 The Pennsylvania State University. All rights reserved.
//

import Foundation
import MapKit

class Marker: NSObject, MKAnnotation {
    let index: Int
    let name: String
    let brief: String
    let detail: String
    let coordinate: CLLocationCoordinate2D
    
    init(index: Int, title: String, brief: String, detail: String, coordinate: CLLocationCoordinate2D) {
        
        self.index = index
        self.name = title
        self.brief = brief
        self.detail = detail
        self.coordinate = coordinate

        super.init()
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return brief
    }
}
