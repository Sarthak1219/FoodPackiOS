//
//  SingleRestaurantMapView.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/5/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import SwiftUI
import MapKit

/**
 Shows Map location of restaurant and user's current location.
 Maybe: Show route and time needed to travel.
 */
struct SingleRestaurantMapView: UIViewRepresentable {
    
    var restaurant: Restaurant;
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(restaurant.latitude), longitude: CLLocationDegrees(restaurant.longitude))
        //numbers are random, will be scalefactor of users distance from restaurant
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct SingleRestaurantMapView_Previews: PreviewProvider {
    
    static let restaurants = RestaurantInput.parseJSONfromLocalFile(filename: validfilename)
    
    static var previews: some View {
        SingleRestaurantMapView(restaurant: restaurants[0])
    }
}
