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
 ContentView is home page for app.
 Shows Navigatable list of restaurants.
 Calls subview RestaurantRowView in list.
 */
struct ContentView: View {
    /**
     Bindable boolean showError is used for displaying an alert if the restuarant array is empty (error occured when fetching data)
     */
    @State private var showError = false;
    /**
     Bindable boolean showUnavailable is used for allowing user to toggle between showing only available restaurants or all
     */
    @State private var showUnavailable = false;
    
    /**
     EnvironmentObject restaurantlist is initialized in scene delegate; stores all restaurants from database.
     */
    @EnvironmentObject var restaurantList: RestaurantList;
    
    var body: some View {
        //add map overview;note to self: need to embed navview in stack
        NavigationView {
            List {
                ForEach(restaurantList.restaurants, id: \.restaurant_ID) { restaurant in
                    //group needed to use conditional
                    Group{
                        if(restaurant.getIsReady() == 1){
                            NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)){
                                RestaurantRowView(restaurant: restaurant)
                            }
                        }
                        else if(showUnavailable){
                            RestaurantRowView(restaurant: restaurant)
                        }
                    }
                }
            }
            .navigationBarTitle("Restaurants")
            .navigationBarItems(leading:
                Toggle(isOn: $showUnavailable){
                    Text("Show All")
                }
                , trailing:
                Button(action: {
                    restaurantList.refresh();
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                         self.showError = self.restaurantList.restaurants.isEmpty;
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                }.padding()
            )
            .onAppear{
                //restaurantList.refresh();
                restaurantList.restaurants.sort();
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                     self.showError = self.restaurantList.restaurants.isEmpty;
                }
            }
            .alert(isPresented: $showError){
                Alert(title: Text("Error!"), message: Text("Unexpected Error loading restaurants. Please Check your internet connection and try again :("));
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RestaurantList(filename: RestaurantInput.testfilename))
    }
}

