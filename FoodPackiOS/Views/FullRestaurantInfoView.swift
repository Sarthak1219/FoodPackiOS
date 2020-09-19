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
    
    @EnvironmentObject var restaurantList: RestaurantList;
    @ObservedObject var restaurant: Restaurant;
    
    var body: some View {
        VStack {
            Spacer()
            VStack{
                HStack {
                    Spacer()
                    Text("Inventory:")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    Text(restaurant.inventory_message)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Divider()
                Text(restaurant.volunteer_message)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 5)
                Button(action: {
                    //refresh list to check if someone has already taken it
                    restaurant.turnOffIsReady(changingList: restaurantList)
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
                .padding(.bottom)
            }
            .padding(.top, 10)
            .background(Color.gray)
            .opacity(0.8)
        }
    }
}

struct FullRestaurantInfoView_Previews: PreviewProvider {
    
    static var restaurantList = RestaurantList(filename: RestaurantInput.testfilename);
    
    static var previews: some View {
        FullRestaurantInfoView(restaurant: restaurantList.restaurants[1]).environmentObject(RestaurantList(filename: RestaurantInput.testfilename))
    }
}
