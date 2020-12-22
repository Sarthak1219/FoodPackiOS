//
//  RestaurantOutput.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 12/22/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import Foundation

/**
 Static Struct RestaurantOutput Describes Output for FoodPack Application
 Used for sending restaurant data to database.
 Allows data to be written to a local file or sent to a database.
 */
struct RestaurantOutput{
    
    /**
     Enumeration RestaurantInputError describes possible errors in RestaurantInput Struct
     */
    enum RestaurantOutputError: Error{
        case encodeError;
        case listIsEmpty;
    }
    
    /**
     RestauratOutput Method convertToJSON returns encoded JSON Data given an array of type Restaurant
     If the array is empty, an RestaurantOutputError.listIsEmpty will be thrown
     If the array cannot be encoded, an RestaurantOutputError.encodeError will be thrown
     */
    static func convertToJSON(restaurants: [Restaurant]) throws -> Data? {
        if(restaurants.isEmpty){
            throw RestaurantOutputError.listIsEmpty;
        }
        
        do {
            let JSONData = try JSONEncoder().encode(restaurants);
            return JSONData;
        } catch {
            throw RestaurantOutputError.encodeError;
        }
    }
    
}
