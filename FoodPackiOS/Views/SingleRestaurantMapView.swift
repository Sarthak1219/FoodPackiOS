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
    
    /**
     Initial function is called and returns empty map view. Using context sets the delegate of the view to an instance of internal class Coordinator.
     */
    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView();
        view.delegate = context.coordinator;
        return view;
    }
    
    /**
     Update function adds restuarant pin and route information, if available. Context is current environment info given by iOS. This includes info about the view and its coordinator.
     */
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //adds restuarant to map
        let restaurantpin = MKPointAnnotation()
        restaurantpin.title = restaurant.restaurant_name
        restaurantpin.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(restaurant.latitude), longitude: CLLocationDegrees(restaurant.longitude))
        uiView.addAnnotation(restaurantpin)
        
        //show user location and route information, if available
        if(restaurantRoute != nil){
            uiView.showsUserLocation = true;//precondition of route being calculated is userLocation being available
            uiView.addOverlay(restaurantRoute!.polyline)//TODO, overlay is not visible
            uiView.setVisibleMapRect(MKMapRect(origin: restaurantRoute!.polyline.boundingMapRect.origin, size: MKMapSize(width: restaurantRoute!.polyline.boundingMapRect.width, height: restaurantRoute!.polyline.boundingMapRect.height * 1.2)), animated: true)
        }
        else{
            uiView.showsUserLocation = false;
            uiView.setRegion(MKCoordinateRegion(center: restaurantpin.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
        }
    }
    
    /**
     Internal function creates instance of Coordinator inner class. Used in MakeUIView method to set view's delegate to Coordinator
     */
    func makeCoordinator() -> Coordinator {
        return Coordinator(self);
    }
    
    /**
     Inner class allows various listener methods for events happening in the map view view.
     Used to provide renderer for drawing route lines.
     */
    class Coordinator: NSObject, MKMapViewDelegate{
        
        /**
         Stores the parent view for use in methods.
         */
        var parent: SingleRestaurantMapView;

        /**
         Constructor sets the parent view state.
         */
        init(_ parent: SingleRestaurantMapView) {
            self.parent = parent;
        }
        
        /**
         Method provides Map View renderer when addOverlay is called to draw route line.
         */
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let routeRenderer = MKPolylineRenderer(overlay: overlay);
            routeRenderer.strokeColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5);//alpha = opacity
            return routeRenderer;
        }
    }
    
}

struct SingleRestaurantMapView_Previews: PreviewProvider {
    
    static var restaurantList = RestaurantList(filename: RestaurantInput.testfilename);
    
    static var previews: some View {
        SingleRestaurantMapView(restaurant: restaurantList.restaurants[1])
    }
}
