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
    
    var body: some View{
        Text("Hello World!")
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    
    //static let restaurants = RestaurantInput.parseJSONfromLocalFile(filename: validfilename)
    
    static var previews: some View {
        RestaurantDetailView()
        //RestaurantDetailView(restaurant: restaurants[0])
    }
}
