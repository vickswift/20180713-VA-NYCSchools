//
//  HighSchoolInfo.swift
//  20180713-VA-NYCSchools
//
//  Created by Victor  Adu on 7/13/18.
//  Copyright © 2018 Filmic. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class HighSchoolInfo: NSObject, MKAnnotation, Decodable {

    var dbn: String?
    var school_name: String?
    var council_district: String?
    var primary_address_line_1: String?
    var city: String?
    var borough: String?
    var state_code: String?
    var zip: String?
    var phone_number: String?
    var website: String?
    var longitude: String?
    var latitude: String?
    
    @objc var title: String?
    @objc var subtitle: String?
    
    var schoolLatitude: Double { return Double(self.latitude ?? "") ?? 0 }
    var schoolLongitude: Double { return Double(self.longitude ?? "") ?? 0 }

    @objc var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: schoolLatitude, longitude: schoolLongitude)
    }
    
}
