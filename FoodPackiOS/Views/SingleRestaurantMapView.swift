//
//  SingleRestaurantMapView.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/5/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

/**
 Shows Map location of restaurant and user's current location.
 Maybe: Show route and time needed to travel.
 Uses helper class UserLocation, which handles location service permissions, location changes, and calculating ETA's/distances
 */
struct SingleRestaurantMapView: UIViewRepresentable {
    
    /**
     ObservedObject restaurant passed from contentview's restaurantList via navigation link
     */
   @ObservedObject var restaurant: Restaurant;
    
    /**
     Variable of type MKRoute stores route from user's current location to restaurant. Used to display route on map. Passed in from RestaurantDetailView. Will be null if user location is not accessible or maps service is not working
     */
    var restaurantRoute: MKRoute?;
    
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //add restuarant to map
        let restaurantpin = MKPointAnnotation()
        restaurantpin.title = restaurant.restaurant_name
        restaurantpin.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(restaurant.latitude), longitude: CLLocationDegrees(restaurant.longitude))
        uiView.addAnnotation(restaurantpin)
        
        //add user location and route information, if available
        //change to if route is nil or not
        
        
        let coordinate = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(restaurant.latitude), longitude: CLLocationDegrees(restaurant.longitude))
        //numbers are random, will be scalefactor of users distance from restaurant
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct SingleRestaurantMapView_Previews: PreviewProvider {
    
    static var restaurantList = RestaurantList(filename: RestaurantInput.testfilename);
    
    static var previews: some View {
        SingleRestaurantMapView(restaurant: restaurantList.restaurants[1])
    }
}
