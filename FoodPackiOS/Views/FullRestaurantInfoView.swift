//
//  FullRestaurantInfoView.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/5/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import SwiftUI
import MapKit

/**
 Show all Restuarant details, including inventory message, volunteer message, and button to accept request.
 */
struct FullRestaurantInfoView: View {
    
    /**
     EnvironmentObject restaurantlist is initialized in scene delegate; stores all restaurants from database.
     Needed in this view so list updates views locally, before info is refreshed automatically from database.
     */
    @EnvironmentObject var restaurantList: RestaurantList;
    /**
     ObservedObject restaurant passed from contentview's restaurantList via navigation link
     */
    @ObservedObject var restaurant: Restaurant;
    
    /**
     Helper variable dateOutput is of type DateFormatter, which allows eta to be displayed from route.
     It is constructed only when route is available (computed value)
     */
    private var dateOutput: DateFormatter{
        let formatter = DateFormatter();
        formatter.dateStyle = .none;
        formatter.timeStyle = .short;
        return formatter;
    }
    
    /**
     Variable of type MKRoute stores route from user's current location to restaurant. Used to show eta in panel. Passed in from RestaurantDetailView. Will be null if user location is not accessible or maps service is not working
     */
    var restaurantRoute: MKRoute?;
    
    var body: some View {
        VStack {
            //Spacer()
            VStack{
                RoundedRectangle(cornerRadius: 75, style: .circular)
                    .fill(Color.red)
                    .frame(width: 100, height: 7.5)
                HStack {
                    Text(restaurant.restaurant_name)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 20)
                        //
                    Spacer()
                    Text("ETA:")
                        .font(.headline)
                        .fontWeight(.bold)
                    Group{
                        if(restaurantRoute == nil){
                            Text("NA")
                        }
                        else{
                            //TODO: add restaurantRoute!.expectedTravelTime to current date for ETA
                            Text(dateOutput.string(from: Date()))
                        }
                    }
                    .font(.callout)
                    .padding(.trailing, 20)
                }
                .foregroundColor(Color.white)
                .padding(.bottom, 20)
                Divider()
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
                        Image(systemName: "square.and.arrow.up.fill")
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
            Spacer()
        }
        .padding(.top, 10)
        .background(Color.gray)
        .opacity(0.8)
        .cornerRadius(15)
    }
}

struct FullRestaurantInfoView_Previews: PreviewProvider {
    
    static var restaurantList = RestaurantList(filename: RestaurantInput.testfilename);
    
    static var previews: some View {
        FullRestaurantInfoView(restaurant: restaurantList.restaurants[1], restaurantRoute: nil).environmentObject(RestaurantList(filename: RestaurantInput.testfilename))
    }
}
