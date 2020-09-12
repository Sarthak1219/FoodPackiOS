//
//  ContentView.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/2/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import SwiftUI
import Combine

/**
 Global Filename Variable for ContentView and all Subviews' previews.
 */
let testfilename: String = "Test_Files/Test_Restaurant_Info";

/**
 ContentView is home page for app.
 Shows Navigatable list of restaurants.
 Calls subview RestaurantRowView in list.
 */
struct ContentView: View {
    
    @ObservedObject var source = RestaurantInput(filename: testfilename);
    //@ObservedObject var source = RestaurantInput();
    
    var body: some View {
        //add map overview (later for funsies)
        NavigationView {
            List {
                ForEach(source.restaurants, id: \.restaurant_ID) { restaurant in
                    //group needed to use conditional
                    Group{
                        if(restaurant.getIsReady() == 1){
                            NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)){
                                RestaurantRowView(restaurant: restaurant);
                            }
                        }
                        else{
                            RestaurantRowView(restaurant: restaurant);
                        }
                    }
                }
            }
            .navigationBarTitle("Restaurants")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

