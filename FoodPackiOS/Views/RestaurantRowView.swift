//
//  RestaurantRowView.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/5/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import SwiftUI

/**
 Subview for displaying a single restaurant's information in ContentView.
 */
struct RestaurantRowView: View {
    
    @ObservedObject var restaurant: Restaurant;
    
    var body: some View {
        VStack(alignment: .leading){
            if(restaurant.getIsReady() == 1){
                Text(restaurant.restaurant_name) .font(.largeTitle).fontWeight(.semibold).foregroundColor(Color.red).padding(.leading)
            }
            else{
                Text(restaurant.restaurant_name) .font(.largeTitle).fontWeight(.semibold).foregroundColor(Color.gray).padding(.leading)
            }
            HStack {
                Text(restaurant.restaurant_address) .font(.headline).multilineTextAlignment(.center).lineLimit(2).padding(.leading).frame(width: 200)
                Spacer()
                if(restaurant.getIsReady() == 1){
                    Text(restaurant.pickup_time).multilineTextAlignment(.center).lineLimit(2).padding(.trailing, 30.0).frame(width: 150)
                }
                    
            }
        }
        .padding(.vertical, 5.0)
    }
}

struct RestaurantRowView_Previews: PreviewProvider {
    
    static var restaurantList = RestaurantList(filename: RestaurantInput.testfilename);
    
    static var previews: some View {
        RestaurantRowView(restaurant: restaurantList.restaurants[1])
    }
}
