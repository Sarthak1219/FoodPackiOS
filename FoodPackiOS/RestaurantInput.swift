//
//  RestaurantInput.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/2/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import Foundation

/**
 Static Struct RestaurantInput Describes Input for FoodPack Application
 Used for getting restaurant data from JSON sources.
 Allows data to be read in from a local file or database, and data to be parsed to an array of type Restaurant.
 */
struct RestaurantInput{
    
    /**
     Final path of script.
     */
    static let scriptname = "http://localhost/foodpackscripts/SelectAllRestaurants.php";
    /**
     Global Filename Variable for ContentView and all Subviews' previews.
     */
    static let testfilename: String = "Test_Files/Test_Restaurant_Info";
    /**
    Global Filename Variable for initializing empty list.
    */
    static let emptyfilename: String = "Test_Files/Test_Empty_Restaurant_Info";
    
    /**
     Enumeration RestaurantInputError describes possible errors in RestaurantInput Struct
     */
    enum RestaurantInputError: Error{
        case fileNotFound;
        case cannotGetDataFromFileUrl;
        case dataIsEmpty;
        case decodeError;
    }
    
    /**
     RestauratInput Method readDataBaseTable stores data from php script -that returns all restaurant_info in JSON- in result completion success case.
     If the script is not found, an RestaurantInputError.fileNotFound will be stored in the result completion failure case.
     If data cannot be retreived from the Url, an RestaurantInputError.cannotGetDataFromFileUrl will be stored in the result completion failure case.
     Result completion is necessary, because URLSession.shared.dataTask does not allow errors to be thrown.
     */
    static func readDataBaseTable(script: String, completion: @escaping (Result<Data?, RestaurantInputError>) -> Void) {
        let url = URL(string: script);
        if(url == nil){
            completion(.failure(RestaurantInputError.fileNotFound));
            return;
        }

        let request = URLRequest(url: url!);

        URLSession.shared.dataTask(with: request) { data, response, error in
            if(error == nil){
                completion(.success(data));
                return;
            }
            completion(.failure(RestaurantInputError.cannotGetDataFromFileUrl));
        }.resume()
    }
    
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
    
    /**
     RestauratInput Method parseJSON returns an array of type Restaurant from given JSONData
     If the JSONData is empty, an RestaurantInputError.dataIsEmpty will be thrown
     If the data cannot be decode into an array of type Restaurant, an RestaurantInputError.decodeError will be thrown
     */
    static func parseJSON(JSONData: Data?) throws -> [Restaurant] {
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
