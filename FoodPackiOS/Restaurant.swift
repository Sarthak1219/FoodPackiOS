//
//  Restaurant.swift
//  FoodPack
//
//  Created by Sarthak Mehta on 8/30/20.
//  Copyright © 2020 Sarthak Mehta. All rights reserved.
//

import Foundation

/**
Restaurant Class describes a Restaurant participating in the FoodPack Program.
Uses Codable Protocol for JSON encoding/decoding
Uses Equatable Protocol for Unit Testing.
Uses ObservableOject Protocol and @published so views auto update when is_ready gets turned off
Used for Displaying Information to the Volunteer App User
Maintains information about the Restaurant's ID, name, location: (address, lat/long), and pickuprequest: (pickup time, inventory message, voluteer message, and whether the restaurant is searching for a volunteer).
Allows the user to see the is_ready state and turn it off once a volunteer accepts the request.
 */
class Restaurant: Codable, Equatable, ObservableObject{
    
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
    @Published private var is_ready: Int;//make published!!
    
    /**
     Because Codable and ObservableObject Protocols dont like each other, doing this is required :(
     Enum of keys in JSON files used
     */
    enum CodingKeys: CodingKey{
        case restaurant_ID, restaurant_name, restaurant_address, latitude, longitude, pickup_time, inventory_message, volunteer_message, is_ready;
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
    Because Codable and ObservableObject Protocols dont like each other, doing this is required :(
    Used when RestaurantInput decodes restaurants from given JSON source.
    */
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self);
        
        restaurant_ID = try container.decode(Int.self, forKey: .restaurant_ID);
        restaurant_name = try container.decode(String.self, forKey: .restaurant_name);
        restaurant_address = try container.decode(String.self, forKey: .restaurant_address);
        latitude = try container.decode(Float32.self, forKey: .latitude);
        longitude = try container.decode(Float32.self, forKey: .longitude);
        pickup_time = try container.decode(String.self, forKey: .pickup_time);
        inventory_message = try container.decode(String.self, forKey: .inventory_message);
        volunteer_message = try container.decode(String.self, forKey: .volunteer_message);
        is_ready = try container.decode(Int.self, forKey: .is_ready);
    }
    
    /**
     Because Codable and ObservableObject Protocols dont like each other, doing this is required :(
     Used to encode restaurant to JSON to be sent to database.
     */
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self);

        try container.encode(restaurant_ID, forKey: .restaurant_ID);
        try container.encode(restaurant_name, forKey: .restaurant_name);
        try container.encode(restaurant_address, forKey: .restaurant_address);
        try container.encode(latitude, forKey: .latitude);
        try container.encode(longitude, forKey: .longitude);
        try container.encode(pickup_time, forKey: .pickup_time);
        try container.encode(inventory_message, forKey: .inventory_message);
        try container.encode(volunteer_message, forKey: .volunteer_message);
        try container.encode(is_ready, forKey: .is_ready);
    }
    
    /**
     Getter for is_ready Parameter. This is neccesary, because  is_ready is a private variable, which should only be changed when the turnOffIsReady method is called.
     */
    func getIsReady() -> Int{
        return self.is_ready;
    }
    
    /**
     Method  Changes the is_ready parameter once a volunteer accepts, so the restaurant is no longer visible in the search table of the app.
     objectWillChange.send() allows the UI to update the home view and not allow the turned off restaurant to be clicked.
     */
    func turnOffIsReady(changingList: RestaurantList){
        if(self.is_ready == 1){
            changingList.objectWillChange.send();
            self.is_ready = 0;
        }
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
