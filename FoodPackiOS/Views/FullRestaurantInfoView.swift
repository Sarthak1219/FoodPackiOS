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
     Variable of type MKRoute stores route from user's current location to restaurant. Used to show eta in panel. Passed in from RestaurantDetailView. Will be null if user location is not accessible or maps service is not working
     */
    var restaurantRoute: MKRoute?;
    
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
     Enum containing cases for route information User can access.
     */
    private enum routeOptions: String{
        case ETA;
        case Time;
        case Distance;
    }
    
    /**
     Private state variable stores user-selected route option.
     */
    @State private var selectedRouteOption = routeOptions.ETA;
    
    var body: some View {
        VStack {
            //Spacer()
            VStack{
                RoundedRectangle(cornerRadius: 75, style: .circular)
                    .fill(Color.red)
                    .frame(width: 100, height: 7.5)
                HStack {
                    Text(restaurant.restaurant_name)
                        .font(.title)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 20)
                        //
                    Spacer()
                    //TODO, allow options of ETA, distance, and time
                    Text(selectedRouteOption.rawValue + ":")
                        .font(.headline)
                        .fontWeight(.bold)
                    Group{
                        if(restaurantRoute == nil){
                            Text("NA")
                        }
                        else{
                            switch selectedRouteOption {
                            case .ETA:
                                //current date + travel time.
                                //dateoutput is declared above
                                Text(dateOutput.string(from: Date() + restaurantRoute!.expectedTravelTime))
                            case .Time:
                                //converted from seconds to min, then result is rounded
                                Text(String(Int((restaurantRoute!.expectedTravelTime/60).rounded())) + " min")
                            case .Distance:
                                //converted from meters to miles, then result is rounded (one decimal place)
                                Text(String((restaurantRoute!.distance / 1609.34 * 10).rounded() / 10) + " mi")
                            }
                        }
                    }
                    .font(.callout)
                    .padding(.trailing, 20)
                }
                .foregroundColor(Color.white)
                .padding(.bottom, -5)
                Picker("Options", selection: $selectedRouteOption){
                    Text("ETA").tag(routeOptions.ETA)
                    Text("Time").tag(routeOptions.Time)
                    Text("Distance").tag(routeOptions.Distance)
                }
                .pickerStyle(SegmentedPickerStyle())
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
                        .lineLimit(2)
                    Spacer()
                }
                Divider()
                Text(restaurant.volunteer_message)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .lineLimit(1)
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
