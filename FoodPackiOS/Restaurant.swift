//
//  Restaurant.swift
//  FoodPack
//
//  Created by Sarthak Mehta on 8/30/20.
//  Copyright © 2020 Sarthak Mehta. All rights reserved.
//

import Foundation

/**
Restaurant Struct describes a Restaurant participating in the FoodPack Program.
Uses Codable Protocol for JSON encoding/decoding
Uses Equatable Protocol for unit testing.
Used for Displaying Information to the Volunteer App User
Maintains information about the Restaurant's ID, name, location: (address, lat/long), and pickuprequest: (pickup time, inventory message, voluteer message, and whether the restaurant is searching for a volunteer).
Allows the is_ready state to be turned off once a volunteer accepts the request.
 */
struct Restaurant: Codable, Equatable{
    
    /** Stores the Participating Restaurant's ID. */
    let restaurant_ID: Int;
    /** Stores the Participating Restaurant's Name. */
    let restaurant_name: String;
    /** Stores the Participating Restaurant's Address. */
    let restaurant_address: String;
    /** Stores the Location's Latitude. */
    let latitude: Float32;
    /** Stores the Location's Longitude. */
    let longitude: Float32;
    /** Stores the Participating Restaurant's Requested Pickup Time. */
    let pickup_time: String;
    /** Stores the Participating Restaurant's Excess Inventory for Pickup. */
    let inventory_message: String;
    /** Stores the Participating Restaurant's Message for the Volunteer. */
    let volunteer_message: String;
    /** Stores if the Participating Restaurant is ready for the Volunteer. 1 if yes, 0 if no (for compatibility with database). */
    var is_ready: Int;
    
    /**
     Method  Changes the is_ready parameter once a volunteer accepts, so the restaurant is no longer visible in the search table of the app.
     */
    mutating func turnOffIsReady(){
        if(is_ready == 1){
            is_ready = 0;
        }
    }
    
    /**
     Constructor Initializes Restaurant object with given iD, name, address, latitude, longitude, pickuptime, inventory message, volunteer message, and whether the restaurat is ready for pickup.
     Only used in unit testing, restaurants will not be created in this app.
     */
    init(restaurant_ID: Int,
     restaurant_name: String,
     restaurant_address: String,
     latitude: Float32,
     longitude: Float32,
     pickup_time: String,
     inventory_message: String,
     volunteer_message: String,
     is_ready: Int){
        self.restaurant_ID = restaurant_ID;
        self.restaurant_name = restaurant_name;
        self.restaurant_address = restaurant_address;
        self.latitude = latitude;
        self.longitude = longitude;
        self.pickup_time = pickup_time;
        self.inventory_message = inventory_message;
        self.volunteer_message = volunteer_message;
        self.is_ready = is_ready;
    }
    
    /**
     Method checks whether two restaurants are duplicates; implements equatable protocol method
     Only used in unit testing, two restaurants will never be equal in practice due to database setup.
     */
    static func == (one:Restaurant, two:Restaurant) -> Bool{
        return one.restaurant_ID == two.restaurant_ID
            && one.restaurant_name == two.restaurant_name
            && one.restaurant_address == two.restaurant_address
            && one.latitude == two.latitude
            && one.longitude == two.longitude
            && one.pickup_time == two.pickup_time
            && one.inventory_message == two.inventory_message
            && one.volunteer_message == two.volunteer_message
            && one.is_ready == two.is_ready;
    }
    
}
