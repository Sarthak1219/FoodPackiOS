//
//  RestaurantInputTests.swift
//  FoodPackiOSTests
//
//  Created by Sarthak Mehta on 9/2/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import XCTest
@testable import FoodPackiOS

/**
RestaurantInputTests class provides unit tests for RestaurantInput methods.
*/
class RestaurantInputTests: XCTestCase {

    let validfilename: String = "Test_Files/Test_Restaurant_Info";
    let DNEfilename: String = "Test_Files/Test_Nowhere_Restaurant_Info";
    let emptyfilename: String = "Test_Files/Test_Empty_Restaurant_Info";
    let incompletefilename: String = "Test_Files/Test_INC_Restaurant_Info";
    
    let r0 = Restaurant(restaurant_ID:1,restaurant_name:"Ben's Barbeque",restaurant_address:"2109 Avent Ferry Rd, Raleigh, NC",latitude:35.779446,longitude:-78.67543,pickup_time:"2020-09-03 20:30:26",inventory_message:"Copy Inventory Here",volunteer_message:"Thanks for helping reduce food waste in our community!",is_ready:0);
    let r1 = Restaurant(restaurant_ID:2,restaurant_name:"Sharkie's Grill",restaurant_address:"2610 Cates Ave, Raleigh, NC",latitude:35.783875,longitude:-78.673126,pickup_time:"2020-09-02 14:48:03",inventory_message:"Copy Inventory Here",volunteer_message:"Thanks for helping reduce food waste in our community!",is_ready:1);
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
     Test's RestaurantInput's constructor and parseJSON Method with a valid LocalFile
     */
    func testParseJSONfromLocalFile_valid() {
        
        let source = RestaurantInput(filename: validfilename);
        XCTAssertEqual(source.restaurants.endIndex, 2);
        
        XCTAssertNoThrow(try RestaurantInput.readLocalFile(filename: validfilename));
        
        do{
            let JSONData = try RestaurantInput.readLocalFile(filename: validfilename);
            let restaurants = try RestaurantInput.parseJSON(JSONData: JSONData);
            XCTAssertEqual(restaurants[0], r0);
            XCTAssertEqual(restaurants[1], r1);
        }
        catch{
            XCTFail("Error Thrown for Valid File");
        }
    }
    
    /**
     Test's RestaurantInput's constructor and parseJSON Method with invalid LocalFiles
     */
    func testParseJSONfromLocalFile_invalid() {
        
        let source1 = RestaurantInput(filename: DNEfilename);
        XCTAssertEqual(source1.restaurants.isEmpty, true);
        
        let source2 = RestaurantInput(filename: emptyfilename);
        XCTAssertEqual(source2.restaurants.isEmpty, true);
        
        let source3 = RestaurantInput(filename: incompletefilename);
        XCTAssertEqual(source3.restaurants.isEmpty, true);
        
        //file DNE
        do{
            //underscore means no name; only checking what happens with method call
            _ = try RestaurantInput.readLocalFile(filename: DNEfilename);
            XCTFail("Allowed Data to be retrieved from a file that DNE");
        }
        catch{
            XCTAssertEqual(error.localizedDescription, RestaurantInputError.fileNotFound.localizedDescription);
        }
        
        //file is empty
        do{
            let JSONData = try RestaurantInput.readLocalFile(filename: emptyfilename);
            //underscore means no name; only checking what happens with method call
            _ = try RestaurantInput.parseJSON(JSONData: JSONData);
            XCTFail("No error was thrown when the Data given was empty.");
        }
        catch(RestaurantInputError.cannotGetDataFromFileUrl){
            XCTFail("Unexpected Error: " + RestaurantInputError.cannotGetDataFromFileUrl.localizedDescription);
        }
        catch{
            XCTAssertEqual(error.localizedDescription, RestaurantInputError.dataIsEmpty.localizedDescription);
        }
        
        //file with incomplete restaurant information
        do{
            let JSONData = try RestaurantInput.readLocalFile(filename: incompletefilename);
            //underscore means no name; only checking what happens with method call
            _ = try RestaurantInput.parseJSON(JSONData: JSONData);
            XCTFail("No error was thrown when the Data given was incomplete.");
        }
        catch(RestaurantInputError.cannotGetDataFromFileUrl){
            XCTFail("Unexpected Error: " + RestaurantInputError.cannotGetDataFromFileUrl.localizedDescription);
        }
        catch{
            XCTAssertEqual(error.localizedDescription, RestaurantInputError.decodeError.localizedDescription);
        }
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
