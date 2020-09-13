//
//  FullRestaurantInfoView.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/5/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import SwiftUI

/**
 Show all Restuarant details, including inventory message, volunteer message, and button to accept request.
 */
struct FullRestaurantInfoView: View {
    
    @ObservedObject var restaurant: Restaurant;
    
    var body: some View {
        VStack {
            Text(restaurant.inventory_message)
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text(restaurant.volunteer_message)
                .font(.subheadline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            Button(action: {
                self.restaurant.turnOffIsReady()
                print(self.restaurant.getIsReady())
                //add updates to database
                //open maps
            }) {
                HStack() {
                    Image(systemName: "square.and.arrow.up")
                    Text("Pickup Food")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(Color.white)
                .background(Color.red)
                .cornerRadius(50)
                .padding(.horizontal, 25)
            }
        }
    }
}

struct FullRestaurantInfoView_Previews: PreviewProvider {
    
    static var source = RestaurantInput(filename: testfilename);
    
    static var previews: some View {
        FullRestaurantInfoView(restaurant: source.restaurants[0])
    }
}
