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
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
     Test's RestaurantInput's readLocalFile method
     */
    func testReadLocalFile() {
        XCTAssertNoThrow(try RestaurantInput.readLocalFile(filename: validfilename));
        
        do{
            //underscore means no name; only checking what happens with method call
            _ = try RestaurantInput.readLocalFile(filename: DNEfilename);
            XCTFail("Allowed Data to be retrieved from a file that DNE");
        }
        catch{
            XCTAssertEqual(error.localizedDescription, RestaurantInputError.fileNotFound.localizedDescription);
        }
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
