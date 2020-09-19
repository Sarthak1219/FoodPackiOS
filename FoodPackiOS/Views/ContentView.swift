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
    //@ObservedObject var restaurantList = RestaurantList(scriptname:  RestaurantInput.scriptname);
    //@ObservedObject var restaurantList = RestaurantList(filename: RestaurantInput.testfilename);
    @EnvironmentObject var restaurantList: RestaurantList;
    
    var body: some View {
        //add map overview (later for funsies)
        
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
                        else{
                            RestaurantRowView(restaurant: restaurant)
                        }
                    }
                }
            }
            .navigationBarTitle("Restaurants")
            .onAppear{
                //self.source.readDataBaseTable(script: RestaurantInput.scriptname);
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                     self.showError = self.restaurantList.restaurants.isEmpty;
                }
            }
            .alert(isPresented: $showError){
                Alert(title: Text("Error!"), message: Text("Unexcepted Error loading restaurants. Please Check your internet connection and try again :("));
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RestaurantList(filename: RestaurantInput.testfilename))
    }
}

