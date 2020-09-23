//
//  UserLocation.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/23/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import Foundation
import CoreLocation

class UserLocation: NSObject, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager();
    
    override init(){
        super.init();
        locationManager.delegate = self;
    }
    
    /**
     Function checks current user location permissions.
     Returns true if location usage is allowed; false otherwise
     If the Authorization is not determined, a request will be made to the user.
     */
    func checkAuthorization() -> Bool {
        if(!CLLocationManager.locationServicesEnabled()){
            return false
        }
        switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                return true;
            case .denied:
                return false;
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                return false;
            case .restricted:
                return false;
            case .authorizedAlways:
                return true;
        @unknown default:
            return false;
        }
    }
}
