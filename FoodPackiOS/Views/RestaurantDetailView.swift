//
//  RestaurantDetailView.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/5/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import SwiftUI
import MapKit

/**
 Constant value for offset needed to hide most of restaurant info panel.
 */
private let PANEL_HIDDEN_OFFSET = UIScreen.main.bounds.height - 275;

/**
 Constant value for offset needed to show  restaurant info panel.
 */
private let PANEL_SHOWN_OFFSET = UIScreen.main.bounds.height - 475;

/**
 RestaurantDetailView is view shown when restaurant is selected from ContentView
 Uses SingleRestaurantMapView to Show Map location of restaurant and user's current location.
 Uses FullRestaurantInfoView to show all details, including inventory message, volunteer message, and button to accept request.
 */
struct RestaurantDetailView: View {
    
    /**
     ObservedObject restaurant passed from contentview's restaurantList in navigation destination link
     */
    @ObservedObject var restaurant: Restaurant;
    
    /**
     EnvironmentObject UserLocation is initialized in scene delegate; stores user location and has method to calculate route to restuarant, used to calculate route and pass route object to detailview
     */
    @EnvironmentObject var userLocationServices: UserLocation;
    
    /**
     Variable storing offset for FullRestaurantInfoView to allow drag gestures.
     */
    @State private var detailOffset = PANEL_HIDDEN_OFFSET;
    
    var body: some View{
        //Text("Hello World!")
        ZStack {
            SingleRestaurantMapView(restaurant: restaurant, restaurantRoute: userLocationServices.getRouteFromDictionary(restaurant: restaurant))
                .edgesIgnoringSafeArea(.all)
            if(restaurant.getIsReady() == 1) {
                FullRestaurantInfoView(restaurant: restaurant, restaurantRoute: userLocationServices.getRouteFromDictionary(restaurant: restaurant))
                    .offset(x: 0, y: detailOffset)
                    .gesture(DragGesture()
                        .onChanged({ value in
                            //TODO: add "resistance" to avoid showing bottom
                            detailOffset =
                                value.location.y;
                        })
                        .onEnded({ value in
                            withAnimation(.easeIn){
                                //moved panel down
                                if(value.translation.height > 0){
                                    detailOffset = PANEL_HIDDEN_OFFSET;
                                }
                                //moved panel up
                                else if(value.translation.height < 0){
                                    detailOffset = PANEL_SHOWN_OFFSET;
                                }
                            }
                        })
                    )
            }
        }
        .onAppear{
            //route is not in the dictionary of userLocationServices
            //this can be because first time accessing this view for this restuarant, errors in getting route the first time, user location being unavailable, or user location has changed/permissions were denied since the first route calculation
            if(userLocationServices.getRouteFromDictionary(restaurant: restaurant) == nil){
                userLocationServices.addRouteToDictionary(restaurant: restaurant);
            }
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        RestaurantDetailView(restaurant: RestaurantList(filename: RestaurantInput.testfilename).restaurants[1]).environmentObject(UserLocation())
    }
}
