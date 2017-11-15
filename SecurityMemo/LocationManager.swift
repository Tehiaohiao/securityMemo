//
//  LocationManager.swift
//  SecurityMemo
//
//  Created by Frank on 11/14/17.
//  Copyright © 2017 SecurityMemoTeam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private var manager: CLLocationManager!
    private var curLocation: CLLocation!
    
     override init() {
        super.init()
        // initialize and configure manager
        self.manager = CLLocationManager()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
        self.manager.delegate = self
        self.curLocation = self.manager.location
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.curLocation = locations[0]
    }
    
    public func getCurCoordinate() -> CLLocation?{
        return self.curLocation
    }
    
    
    
    // function to convert a coordinate to a readable address and handle the result
    public static func getAddressFromCoordinate (coordinate: CLLocation, completionHandler: @escaping (_ result: String?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(coordinate) { (placemark, error) in
            if error != nil {
                print(error.debugDescription)
                completionHandler(nil)
            }
            else {
                if let place = placemark?[0] {
                    var address: String = ""
                    if place.subThoroughfare != nil {
                        address += "\(place.subThoroughfare!)"
                    }
                    if place.thoroughfare != nil {
                        address += ", \(place.thoroughfare!)"
                    }
                    if place.subLocality != nil {
                        address += ", \(place.subLocality!)"
                    }
                    if place.locality != nil {
                        address += ", \(place.locality!)"
                    }
                    
                    if address == "" {
                        completionHandler(nil)
                    }
                    else {
                        if address[address.startIndex] == "," {
                            address = address.substring(from: address.index(address.startIndex, offsetBy: 1))
                        }
                        completionHandler(address)
                    }
                }
                else {
                    completionHandler(nil)
                }
            }
        }
    }
}
