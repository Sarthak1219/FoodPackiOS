//
//  RestaurantInput.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/2/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import Foundation

/**
 Enumeration RestaurantInputError describes possible errors in RestaurantInput Class
 */
enum RestaurantInputError: Error{
    case fileNotFound;
    case cannotGetDataFromFileUrl;
    case dataIsEmpty;
    case decodeError;
}

/**
 Class RestaurantInput Describes Input for FoodPack Application
 Used for getting restaurant data from JSON sources.
 Allows data to be read in from a local file or database, and data to be parsed to an array of type Restaurant.
 */
class RestaurantInput{
    
    /**
     RestauratInput Method readLocalFile returns data from given filename
     If the file is not found, an RestaurantInputError.fileNotFound will be thrown
     If data cannot be retreived from the fileUrl, an RestaurantInputError.cannotGetDataFromFileUrl will be thrown
     */
    static func readLocalFile(filename: String) throws -> Data?{
        guard let filePath = Bundle.main.path(forResource: filename, ofType: "json") else {
            throw RestaurantInputError.fileNotFound;
        }
        
        let fileUrl = URL(fileURLWithPath: filePath);
        
        do {
            let JSONData = try Data(contentsOf: fileUrl);
            return JSONData;
        } catch {
            throw RestaurantInputError.cannotGetDataFromFileUrl;
        }
    }
    
    
    static func readDataBaseTable(){
    //TODO
    }
    
    /**
     RestauratInput Method parseJSON returns an array of type Restaurant from given JSONData
     If the JSONData is empty, an RestaurantInputError.dataIsEmpty will be thrown
     If the data cannot be decode into an array of type Restaurant, an RestaurantInputError.decodeError will be thrown
     */
    static func parseJSON(JSONData: Data?) throws -> [Restaurant]{
        //if the data is null, statement evaluates to true automatically
        if(JSONData?.isEmpty ?? true){
            throw RestaurantInputError.dataIsEmpty;
        }
        
        do {
            let restaurants = try JSONDecoder().decode([Restaurant].self, from: JSONData!);
            return restaurants;
        } catch {
            throw RestaurantInputError.decodeError;
        }
    }
    
}
