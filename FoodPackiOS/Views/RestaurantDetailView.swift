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
    
    /**
     Variable storing offset for FullRestaurantInfoView to allow drag gestures.
     */
    @State private var detailOffset = CGFloat(200);
    
    var body: some View{
        //Text("Hello World!")
        ZStack {
            SingleRestaurantMapView(restaurant: restaurant)
                .edgesIgnoringSafeArea(.all)
            if(restaurant.getIsReady() == 1){
                FullRestaurantInfoView(restaurant: restaurant)
                    .offset(x: 0, y: detailOffset)
                    .gesture(DragGesture()
                        .onChanged({ value in
                            //add "resistance"
                            detailOffset += value.translation.height;
                        })
                        .onEnded({ value in
                            //withAnimation(.spring(response: 0.2, dampingFraction: 0.1, blendDuration: 0)){
                                if(detailOffset > 200){
                                    detailOffset = 200;
                                }
                                else if(detailOffset < 0){
                                    detailOffset = 0;
                                }
                            //}
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
