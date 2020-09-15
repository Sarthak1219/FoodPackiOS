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

    //other filenames declared in RestaurantInput
    let DNEfilename: String = "Test_Files/Test_Nowhere_Restaurant_Info";
    let incompletefilename: String = "Test_Files/Test_INC_Restaurant_Info";
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //TODO add tests for getting data from database
    
    /**
     Test's RestaurantInput's constructor and parseJSON Method with a valid LocalFile
     */
    func testParseJSONfromLocalFile_valid() {
        do{
            let JSONData = try RestaurantInput.readLocalFile(filename: RestaurantInput.testfilename);
            _ = try RestaurantInput.parseJSON(JSONData: JSONData);
        }
        catch{
            XCTFail("Error Thrown for Valid File");
        }
    }
    
    /**
     Test's RestaurantInput's constructor and parseJSON Method with invalid LocalFiles
     */
    func testParseJSONfromLocalFile_invalid() {
        
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
            let JSONData = try RestaurantInput.readLocalFile(filename: RestaurantInput.emptyfilename);
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
