//
//  Maps.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/17/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import Foundation
import MapKit

struct Maps {
    static func openMaps(lat: String , long: String , distance: Double ,name: String){
        let doubleLat = Double(lat)!
        let doubleLong = Double(long)!
        
        let latitude: CLLocationDegrees = doubleLat
        let longitude: CLLocationDegrees = doubleLong
        let regionDistance:CLLocationDistance = distance
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }
}
