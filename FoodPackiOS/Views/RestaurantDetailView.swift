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
     Variable of type MKRoute stores route from user's current location to restaurant. Used to display route on map and give eta in panel. This is passed in from the navigationlink in content view. Will be null if user location is not accessible or maps service is not working
     */
    var restaurantRoute: MKRoute?;
    
    /**
     Variable storing offset for FullRestaurantInfoView to allow drag gestures.
     */
    @State private var detailOffset = UIScreen.main.bounds.height - 220;
    
    var body: some View{
        //Text("Hello World!")
        ZStack {
            SingleRestaurantMapView(restaurant: restaurant, restaurantRoute: restaurantRoute)
                .edgesIgnoringSafeArea(.all)
            if(restaurant.getIsReady() == 1) {
                FullRestaurantInfoView(restaurant: restaurant)
                    .offset(x: 0, y: detailOffset)
                    .gesture(DragGesture()
                        .onChanged({ value in
                            //add "resistance"
                            detailOffset =
                                value.location.y;
                        })
                        .onEnded({ value in
                            withAnimation(.easeIn){
                                print(restaurantRoute.debugDescription)
                                //moved panel down
                                if(value.translation.height > 0){
                                    detailOffset = UIScreen.main.bounds.height - 220;
                                }
                                //moved panel up
                                else if(value.translation.height < 0){
                                    detailOffset = UIScreen.main.bounds.height - 440;
                                }
                            }
                        })
                    )
            }
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        RestaurantDetailView(restaurant: RestaurantList(filename: RestaurantInput.testfilename).restaurants[1]).environmentObject(UserLocation())
    }
}
