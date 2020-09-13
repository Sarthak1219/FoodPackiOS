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
 Uses ObservableObject Protocol and @published so views auto update with changes in a restaurant in the list from the database
 Used for getting restaurant data from JSON sources.
 Allows data to be read in from a local file or database, and data to be parsed to an array of type Restaurant.
 */
class RestaurantInput: ObservableObject{
    
    /**
     Array of restaurants; @published allows UI to auto update when list changes/is refreshed.
     */
    @Published var restaurants: [Restaurant];
    /**
     Final path of script.
     */
    static let scriptname = "http://localhost/foodpackscripts/SelectAllRestaurants.php";
    
    /**
     Initializer for input using default final path for script.
     */
    convenience init() {
        self.init(scriptname: RestaurantInput.scriptname);
    }
    
    /**
     Initializer for input given script for testing.
     */
    init(scriptname: String) {
        self.restaurants = [];
        readDataBaseTable(script: scriptname);
    }
    
    /**
     Initializer for input given local file for testing.
     */
    init(filename: String) {
        do{
            let JSONData = try RestaurantInput.readLocalFile(filename: filename);
            let restaurants = try RestaurantInput.parseJSON(JSONData: JSONData);
            self.restaurants = restaurants;
        }
        catch{
            self.restaurants = [];
        }
    }
    
    /**
     RestauratInput Method readDataBaseTable stores data from php script -that returns all restaurant_info in JSON- in result completion success case.
     If the script is not found, an RestaurantInputError.fileNotFound will be printed
     If data cannot be retreived from the Url, the method will return without setting restaurants.
     URLSession.shared.dataTask does not allow errors to be thrown, and Result didnt work, so no other throwing errors :(
     */
    func readDataBaseTable(script: String) {
        self.restaurants = [];
        guard let url = URL(string: script) else {
            print(RestaurantInputError.fileNotFound.localizedDescription);
            return;
        }

        let request = URLRequest(url: url);

        let config = URLSessionConfiguration.default;
        config.waitsForConnectivity = true;
        
        URLSession(configuration: config).dataTask(with: request) { data, response, error in
            if(error == nil){
                do{
                    let restaurants = try RestaurantInput.parseJSON(JSONData: data);
                    DispatchQueue.main.async {
                        self.restaurants = restaurants;
                    }
                    return;
                }
                catch{
                    //error cannot be dataisEmpty, because error is nil, so data not empty
                    //error is decode error
                    return;
                }
            }
            print(error!.localizedDescription);
        }.resume()
    }
    
//        /**
//         RestauratInput Method readDataBaseTable stores data from php script -that returns all restaurant_info in JSON- in result completion success case.
//         If the script is not found, an RestaurantInputError.fileNotFound will be stored in the result completion failure case.
//         If data cannot be retreived from the Url, an RestaurantInputError.cannotGetDataFromFileUrl will be stored in the result completion failure case.
//         Result completion is necessary, because URLSession.shared.dataTask does not allow errors to be thrown.
//         */
//        func readDataBaseTable(script: String, completion: @escaping (Result<[Restaurant], RestaurantInputError>) -> Void) {
//            let url = URL(string: script);
//            if(url == nil){
//                completion(.failure(RestaurantInputError.fileNotFound));
//                return;
//            }
//
//            let request = URLRequest(url: url!);
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if(error == nil){
//                    do{
//                        let restaurants = try RestaurantInput.parseJSON(JSONData: data);
//                        completion(.success(restaurants));
//                        return;
//                    }
//                    catch{
//                        //error cannot be dataisEmpty, because error is nil, so data not empty
//                        completion(.failure(RestaurantInputError.decodeError));
//                        return;
//                    }
//                }
//                completion(.failure(RestaurantInputError.cannotGetDataFromFileUrl));
//            }.resume()
//        }
    
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
