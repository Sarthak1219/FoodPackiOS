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
    var test_is_ready: Int = 0;
    
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
        var r = Restaurant(restaurant_ID: test_restaurant_ID, restaurant_name: test_restaurant_name, restaurant_address: test_restaurant_address, latitude: test_latitude, longitude: test_longitude, pickup_time: test_pickup_time, inventory_message: test_inventory_message, volunteer_message: test_volunteer_message, is_ready: test_is_ready);
        
        XCTAssertEqual(r.restaurant_ID, test_restaurant_ID);
        XCTAssertEqual(r.restaurant_name, test_restaurant_name);
        XCTAssertEqual(r.restaurant_address, test_restaurant_address);
        XCTAssertEqual(r.latitude, test_latitude);
        XCTAssertEqual(r.longitude, test_longitude);
        XCTAssertEqual(r.pickup_time, test_pickup_time);
        XCTAssertEqual(r.inventory_message, test_inventory_message);
        XCTAssertEqual(r.volunteer_message, test_volunteer_message);
        //getter necessary, bc is_ready is private
        XCTAssertEqual(r.getIsReady(), test_is_ready);
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
