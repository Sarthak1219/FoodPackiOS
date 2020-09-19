//
//  RestaurantListTests.swift
//  FoodPackiOSTests
//
//  Created by Sarthak Mehta on 9/15/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import XCTest
@testable import FoodPackiOS

class RestaurantListTests: XCTestCase {

    //other filenames declared in RestaurantInput
    let DNEfilename: String = "Test_Files/Test_Nowhere_Restaurant_Info";
    let incompletefilename: String = "Test_Files/Test_INC_Restaurant_Info";
    
    let r0 = Restaurant(restaurant_ID:1,restaurant_name:"Ben's Barbeque",restaurant_address:"2109 Avent Ferry Rd, Raleigh, NC",latitude:35.779446,longitude:-78.67543,pickup_time:"2020-09-03 20:30:26",inventory_message:"Copy Inventory Here",volunteer_message:"Thanks for helping reduce food waste in our community!",is_ready:0);
    let r1 = Restaurant(restaurant_ID:2,restaurant_name:"Sharkie's Grill",restaurant_address:"2610 Cates Ave, Raleigh, NC",latitude:35.783875,longitude:-78.673126,pickup_time:"2020-09-02 14:48:03",inventory_message:"Copy Inventory Here",volunteer_message:"Thanks for helping reduce food waste in our community!",is_ready:1);
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //TODO add tests for constructing from database
    
    func testRestaurantListFileNameConstructor_valid() throws {
        let testlist = RestaurantList(filename: RestaurantInput.testfilename);
        
        //check if values are same
        XCTAssertEqual(testlist.restaurants[0], r0);
        XCTAssertEqual(testlist.restaurants[1], r1);
        
        //check if foreach references are same
        var index = 0;
        for restaurant in testlist.restaurants {
            XCTAssertTrue(restaurant === testlist.restaurants[index]);
            index += 1;
        }
        
        testlist.restaurants[1].turnOffIsReady();
        
        //check if values are updated
        XCTAssertEqual(testlist.restaurants[0], r0);
        XCTAssertNotEqual(testlist.restaurants[1], r1);
        
        //check if foreach references are same
        index = 0;
        for restaurant in testlist.restaurants {
            XCTAssertTrue(restaurant === testlist.restaurants[index]);
            index += 1;
        }
    }

    func testRestaurantListFileNameConstructor_invalid() throws {
        let testlist1 = RestaurantList(filename: RestaurantInput.emptyfilename);
        //check if array is empty
        XCTAssertTrue(testlist1.restaurants.isEmpty);
        
        let testlist2 = RestaurantList(filename: DNEfilename);
        //check if array is empty
        XCTAssertTrue(testlist2.restaurants.isEmpty);
        
        let testlist3 = RestaurantList(filename: incompletefilename);
        //check if array is empty
        XCTAssertTrue(testlist3.restaurants.isEmpty);
    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
