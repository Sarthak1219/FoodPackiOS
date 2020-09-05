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
    
    var restaurant: Restaurant;
    
    var body: some View {
        VStack(alignment: .leading){
            Text(restaurant.restaurant_name) .font(.largeTitle).fontWeight(.semibold).foregroundColor(Color.red).padding(.leading)
            HStack {
                Text(restaurant.restaurant_address) .font(.headline).multilineTextAlignment(.center).lineLimit(2).padding(.leading).frame(width: 200)
                Spacer()
                Text(restaurant.pickup_time)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.trailing, 30.0)
                    .frame(width: 150)
                    
            }
        }
        .padding([.top, .bottom], 5.0)
    }
}

struct RestaurantRowView_Previews: PreviewProvider {
    
    static let restaurants = RestaurantInput.parseJSONfromLocalFile(filename: validfilename)
    
    static var previews: some View {
        RestaurantRowView(restaurant: restaurants[1])
    }
}
