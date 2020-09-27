//
//  UserLocation.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/23/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import Foundation
import CoreLocation

/**
UserLocation class is a helper class for map views.
Uses NSObject and CLLocationManagerDelegate protocols to allow updates to user location and view.
 Maintains an instance of a locationManager, which allows access to the user's location.
 Maintains the user's current location as it is updated.
 Includes private method for checking permissions.
 */
class UserLocation: NSObject, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager();
    var currentLocation: CLLocationCoordinate2D?
    
    override init(){
        super.init();
        locationManager.delegate = self;
    }
    
    /**
     Function checks current user location permissions.
     Returns true if location usage is allowed; false otherwise
     If the app Authorization is not determined, a request will be made to the user.
     */
    private func checkAuthorization() -> Bool {
        //system wide check
        if(!CLLocationManager.locationServicesEnabled()){
            locationManager.stopUpdatingLocation();
            return false;
        }
        //app permission check
        switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation();
                return true;
            case .denied:
                locationManager.stopUpdatingLocation();
                return false;
            case .notDetermined:
                locationManager.stopUpdatingLocation();
                locationManager.requestWhenInUseAuthorization()
                return false;
            case .restricted:
                locationManager.stopUpdatingLocation();
                return false;
            case .authorizedAlways:
                locationManager.startUpdatingLocation();
                return true;
        @unknown default:
            locationManager.stopUpdatingLocation();
            return false;
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if(checkAuthorization()){
            currentLocation = locationManager.location?.coordinate;
        }
        else{
            currentLocation = nil;
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        <#code#>
    }
}
