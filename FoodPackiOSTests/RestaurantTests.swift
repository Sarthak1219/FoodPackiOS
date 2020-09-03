//
//  FoodPackiOSTests.swift
//  FoodPackiOSTests
//
//  Created by Sarthak Mehta on 9/2/20.
//  Copyright © 2020 FoodPack. All rights reserved.
//

import XCTest
@testable import FoodPackiOS

/**
 RestaurantTests class provides unit tests for the Restaurant object.
 Note that the validity of the Restaurant parameters is not tested here; that will be handled when a Restaurant enters their own data from a different source.
 */
class RestaurantTests: XCTestCase {

    let test_restaurant_ID: Int = 7;
    let test_restaurant_name: String = "Sharkie's Grill";
    let test_restaurant_address: String = "2610 Cates Ave, Raleigh, NC";
    let test_latitude: Float32 = 35.783875;
    let test_longitude: Float32 = -78.673126;
    let test_pickup_time: String = "2020-09-02 14:48:03";
    let test_inventory_message: String = "Copy Inventory Here";
    let test_volunteer_message: String = "Thanks for helping reduce food waste in our community!";
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
     Tests the Restaurant's Constructor; Testing for use in RestaurantInputTests class.
     */
    func testRestaurantConstructor() {
        //r is let, because is_ready will not be changed
        let r = Restaurant(restaurant_ID: test_restaurant_ID, restaurant_name: test_restaurant_name, restaurant_address: test_restaurant_address, latitude: test_latitude, longitude: test_longitude, pickup_time: test_pickup_time, inventory_message: test_inventory_message, volunteer_message: test_volunteer_message, is_ready: 0);
        
        XCTAssertEqual(r.restaurant_ID, test_restaurant_ID);
        XCTAssertEqual(r.restaurant_name, test_restaurant_name);
        XCTAssertEqual(r.restaurant_address, test_restaurant_address);
        XCTAssertEqual(r.latitude, test_latitude);
        XCTAssertEqual(r.longitude, test_longitude);
        XCTAssertEqual(r.pickup_time, test_pickup_time);
        XCTAssertEqual(r.inventory_message, test_inventory_message);
        XCTAssertEqual(r.volunteer_message, test_volunteer_message);
        //getter necessary, bc is_ready is private
        XCTAssertEqual(r.getIsReady(), 0);
    }
    
    /**
     Tests Restaurant's implementation of Equatable Protocol's method ==; Testing for use in RestaurantInputTests class.
     */
    func testequatablemethod(){
        //r1 is let, because is_ready will not be changed
        let r1 = Restaurant(restaurant_ID: test_restaurant_ID, restaurant_name: test_restaurant_name, restaurant_address: test_restaurant_address, latitude: test_latitude, longitude: test_longitude, pickup_time: test_pickup_time, inventory_message: test_inventory_message, volunteer_message: test_volunteer_message, is_ready: 0);
        //r2 is let, because is_ready will not be changed
        let r2 = Restaurant(restaurant_ID: test_restaurant_ID, restaurant_name: test_restaurant_name, restaurant_address: test_restaurant_address, latitude: test_latitude, longitude: test_longitude, pickup_time: test_pickup_time, inventory_message: test_inventory_message, volunteer_message: test_volunteer_message, is_ready: 0);
        //r3 is let, because is_ready will not be changed
        let r3 = Restaurant(restaurant_ID: test_restaurant_ID, restaurant_name: test_restaurant_name, restaurant_address: test_restaurant_address, latitude: test_latitude, longitude: test_longitude, pickup_time: test_pickup_time, inventory_message: test_inventory_message, volunteer_message: test_volunteer_message, is_ready: 1);
        
        XCTAssertTrue(r1 == r2);
        XCTAssertFalse(r1 == r3);
    }
    
    /**
     Tests Restaurant's turnOffIsReady Method.
     */
    func testTurnOffIsReady() {
        //r1 is var, because is_ready may be changed
        var r1 = Restaurant(restaurant_ID: test_restaurant_ID, restaurant_name: test_restaurant_name, restaurant_address: test_restaurant_address, latitude: test_latitude, longitude: test_longitude, pickup_time: test_pickup_time, inventory_message: test_inventory_message, volunteer_message: test_volunteer_message, is_ready: 1);
        
        r1.turnOffIsReady();
        XCTAssertEqual(r1.getIsReady(), 0);
        r1.turnOffIsReady();
        XCTAssertEqual(r1.getIsReady(), 0);
        
        var r2 = Restaurant(restaurant_ID: test_restaurant_ID, restaurant_name: test_restaurant_name, restaurant_address: test_restaurant_address, latitude: test_latitude, longitude: test_longitude, pickup_time: test_pickup_time, inventory_message: test_inventory_message, volunteer_message: test_volunteer_message, is_ready: 0);
        
        r2.turnOffIsReady();
        XCTAssertEqual(r2.getIsReady(), 0);
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
