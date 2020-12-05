//
//  UserLocation.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/23/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

/**
UserLocation class is a helper class for map views.
Uses NSObject and CLLocationManagerDelegate protocols to allow updates to user location and view.
 Uses ObservableOject Protocol and @published so map views auto update when user's location changes
 Maintains an instance of a locationManager, which allows access to the user's location.
 Maintains the user's current location as it is updated.
 Includes private method for checking permissions.
 */
class UserLocation: NSObject, CLLocationManagerDelegate, ObservableObject{
    
    /**
     Location Manager Instance, allows retrieval of location, and updates to location
     */
    let locationManager = CLLocationManager();
    /**
     Stores user's current location.
     */
    @Published private var currentLocation: CLLocationCoordinate2D?;
    
    override init(){
        super.init();
        locationManager.delegate = self;
    }
    
    private func createRequest(restaurant: Restaurant) -> MKDirections.Request{
        let request = MKDirections.Request();
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation!));
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(
                                                                latitude: CLLocationDegrees(restaurant.latitude), longitude: CLLocationDegrees(restaurant.longitude))));
        request.departureDate = Date();//current date/time
        request.requestsAlternateRoutes = false;
        request.transportType = .automobile;
        return request;
    }
    
    /**
     Funtion returns MKRoute object given restaurant to calculate route from currentLocation to restaurant.
     If the currentLocation is null, or the response from apple servers returns an error, the method returns null..
     TODO
     */
    func getRoute(restaurant: Restaurant) -> MKRoute? {
        if(currentLocation == nil){
            return nil;
        }
        let request = createRequest(restaurant: restaurant);
        let directions = MKDirections(request: request);
        //variable declared so result from service call can be used in method
        var directionResponse: MKDirections.Response?;
        directions.calculate { result, error in
            directionResponse = result;
        }
        //return route (only 1 bc specified in request) or nil if error was returned (if result is nil, there had to be an error)
        //rn, this will always be null, because calculate method is async
        return directionResponse?.routes[0] ?? nil;
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
                locationManager.requestWhenInUseAuthorization();
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
    
    /**
     Location Manager Delegates method which automatically gets called when the authorization is changed.
     Calls private checkAuthorization method to make sure location can be retrieved.
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if(checkAuthorization()){
            currentLocation = locationManager.location?.coordinate;
        }
        else{
            currentLocation = nil;
        }
    }
    
    /**
     Location Manager Delegates method which automatically gets called when the loction of device is changed.
     Updated currentLocation field to latest location update.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last?.coordinate;
    }
    
}
