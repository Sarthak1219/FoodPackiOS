//
//  RestaurantList.swift
//  FoodPackiOS
//
//  Created by Sarthak Mehta on 9/15/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import Foundation

/**
 RestaurantList Class describes the list of restaurants retrieved from database/local file.
 Uses ObservableOject Protocol and @published so views auto update when the array is changed.
 Maintains information about the list of restaurants.
 */
class RestaurantList: ObservableObject {
    
    /** Array of restaurants; @published allows UI to auto update when list changes/is refreshed. */
    @Published var restaurants: [Restaurant];
    
    /**
     Initializer for RestaurantList given scriptname
     Uses RestaurantInput's readDataBaseTable and parseJSON methods.
     */
    init(scriptname: String){
        self.restaurants = [];//needed so self.restaurants can be set in completion of readDataBaseTable method
        RestaurantInput.readDataBaseTable(script: RestaurantInput.scriptname){ result in
            do{
                let JSONData = try result.get();//only works if the result has a success case
                let restaurants = try RestaurantInput.parseJSON(JSONData: JSONData);
                self.restaurants = restaurants;
            }
            catch{
                self.restaurants = [];
            }
        }
    }
    
    /**
     Initializer for RestaurantList given filename
     Uses RestaurantInput's readLocalFile and parseJSON methods.
     */
    init(filename: String){
        do{
            let JSONData = try RestaurantInput.readLocalFile(filename: filename);
            let restaurants = try RestaurantInput.parseJSON(JSONData: JSONData);
            self.restaurants = restaurants;
        }
        catch{
            self.restaurants = [];
        }
    }
}
