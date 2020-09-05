//
//  ContentView.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/2/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import SwiftUI

let validfilename: String = "Test_Files/Test_Restaurant_Info";

struct ContentView: View {
    
    let restaurants = RestaurantInput.parseJSONfromLocalFile(filename: validfilename);
    
    var body: some View {
        NavigationView {
            //add map overview (later for funsies)
            List {
                ForEach(restaurants, id: \.restaurant_ID) { restaurant in
                    VStack(alignment: .leading){
                        Text(restaurant.restaurant_name).font(.title)
                        //Text(restaurant.pickup_time).font(.caption)
                        Text(restaurant.restaurant_address).font(.callout)
                    }
                    .padding([.top, .bottom], 10)
                }
                //.listRowBackground(Color.init(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.8));
            }
            .navigationBarTitle("FoodPack Restaurants");
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
