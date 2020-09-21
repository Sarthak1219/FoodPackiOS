//
//  RestaurantDetailView.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/5/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import SwiftUI

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
    
    var body: some View{
        //Text("Hello World!")
        ZStack {
            SingleRestaurantMapView(restaurant: restaurant)
                .edgesIgnoringSafeArea(.all)
            if(restaurant.getIsReady() == 1){
                FullRestaurantInfoView(restaurant: restaurant)
            }
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    
    static var restaurantList = RestaurantList(filename: RestaurantInput.testfilename);
    
    static var previews: some View {
        RestaurantDetailView(restaurant: restaurantList.restaurants[1])
    }
}
