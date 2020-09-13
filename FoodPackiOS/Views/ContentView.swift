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
Global Filename Variable for initializing empty list.
*/
let emptyfilename: String = "Test_Files/Test_Empty_Restaurant_Info";

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
    //@ObservedObject var source = RestaurantInput();
    @ObservedObject var source = RestaurantInput(filename: testfilename);
    
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
            .onAppear{
                //self.source.readDataBaseTable(script: RestaurantInput.scriptname);
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                     self.showError = self.source.restaurants.isEmpty;
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
        ContentView()
    }
}

