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
 Uses ObservableOject Protocol and @published so map views auto update when user's location changes and routes have been calculated
 Maintains an instance of a locationManager, which allows access to the user's location.
 Maintains the user's current location as it is updated.
 Maintains a dictionary of routes calculated to given restaurants.
 Includes methods for calculating routes (added to dictionary) and getting a route given the restaurant.
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
    
    /**
     Stores collection of routes calculated for UI.
     Key is restuarant_ID, value is route calculated.
     */
    @Published private var routeDictionary: [Int: MKRoute] = [:];
    
    /**
     Constructor initializes CLLocationManagerDelegate
     */
    override init(){
        super.init();
        locationManager.delegate = self;
    }
    
    /**
     Helper method configures request and returns for use in route calculation
     Precondition: currentLocation must not be null
     */
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
     Helper method calls MKDirections' calculate method with a completion
     If there is an error, it is stored in the failure completion case. Otherwise, the response will be stored in success
     */
    private func calculateRoute(routeRequest: MKDirections.Request, completion: @escaping (Result<MKDirections.Response, Error>) -> Void) {
        let directionsHelper = MKDirections(request: routeRequest);
        if(directionsHelper.isCalculating){
            directionsHelper.cancel();//cancels previous request if it is still calculating
        }
        directionsHelper.calculate { (response, error) in
            if(error == nil){
                completion(.success(response!));
                return;
            }
            completion(.failure(error!));
        }
    }
    
    /**
     Funtion adds MKRoute object given restaurant from route calculation to user location's dictionary of routes
     If the currentLocation is null, or the response from apple servers returns an error, nothing happens to the dictionary (no added nil's)
     */
    func addRouteToDictionary(restaurant: Restaurant) {
        if(currentLocation == nil){
            //do nothing, the dictionary will remain the same
            return;
        }
        
        //calls private helper func
        calculateRoute(routeRequest: createRequest(restaurant: restaurant)){ result in
            do{
                //adds/updates route to given restuarant. result.get() will throw if error was returned from calculate method
                try self.routeDictionary[restaurant.restaurant_ID] = result.get().routes[0];
            } catch{
                //do nothing, the dictionary will remain the same
            }
        }
    }
    
    /**
     Function returns route given restuarant. If the restuarant does not have a route, the function returns nil.
     */
    func getRouteFromDictionary(restaurant: Restaurant) -> MKRoute? {
        if(self.routeDictionary.index(forKey: restaurant.restaurant_ID) == nil){//restuarant not in dictionary
            return nil;
        }
        return self.routeDictionary[restaurant.restaurant_ID];
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
            routeDictionary.removeAll();//because location access is denied, previous routes are now invalid (if any)
        }
    }
    
    /**
     Location Manager Delegates method which automatically gets called when the loction of device is changed.
     Updated currentLocation field to latest location update.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last?.coordinate;
        routeDictionary.removeAll();//because location has changed, previous routes are now invalid
    }
    
}
