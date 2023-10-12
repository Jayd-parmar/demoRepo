//
//  weatherAppTests.swift
//  weatherAppTests
//
//  Created by Jaydip Parmar on 03/10/23.
//

import XCTest
import weatherApp

final class weatherAppTests: XCTestCase {

    let weatherInstance: WeatherData = WeatherDataMock()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_weatherApi() {
        //ACT
        let expectation = self.expectation(description: "API call completes successfully")
        weatherInstance.fetchWeatherData
            {
            response in
                switch response {
                case .success(let weather):
//                    self.weatherData = weather
//                    self.eventHandler?(.dataLoaded)
                    XCTAssertNotNil(weather, "Data is not coming")
                    expectation.fulfill()
                case .failure(let error):
                    print("\(error)")
                }
                
            }
        
//        print(weatherInstance.weatherData)
//        weatherInstance.eventHandler = { [weak self] event in
//            XCTAssertNotNil(data, "Data should not be nil")
           
        
        //Assert
//        let expectation = self.expectation(description: "API call completes successfully")
        waitForExpectations(timeout: 10, handler: nil)
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
