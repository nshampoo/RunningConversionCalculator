//
//  PaceCalculatorTests.swift
//  RunningConversionCalculatorTests
//
//  Created by Nicholas Shampoe on 3/29/23.
//

import XCTest
@testable import RunningConversionCalculator

class PaceCalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testThrowsWhenInstantingNegativeData() throws {
        XCTAssertThrowsError(try PaceCalculator(time: -1, distance: 1, pace: 1), "Negative values should throw an error") { error in
            XCTAssertEqual(error as! PaceCalculator.SessionErrors, PaceCalculator.SessionErrors.NegativeInputError)
        }
        
        XCTAssertThrowsError(try PaceCalculator(time: 1, distance: -1, pace: 1), "Negative values should throw an error") { error in
            XCTAssertEqual(error as! PaceCalculator.SessionErrors, PaceCalculator.SessionErrors.NegativeInputError)
        }
        
        XCTAssertThrowsError(try PaceCalculator(time: 1, distance: 1, pace: -1), "Negative values should throw an error") { error in
            XCTAssertEqual(error as! PaceCalculator.SessionErrors, PaceCalculator.SessionErrors.NegativeInputError)
        }
    }
    
    func testThrowsWhenInstantiatingTooManyNulls() throws {
        XCTAssertThrowsError(try PaceCalculator(), "Too many nil values should report an error") { error in
            XCTAssertEqual(error as! PaceCalculator.SessionErrors, PaceCalculator.SessionErrors.NotEnoughInputError)
        }
        
        XCTAssertThrowsError(try PaceCalculator(time: 1), "Too many nil values should report an error") { error in
            XCTAssertEqual(error as! PaceCalculator.SessionErrors, PaceCalculator.SessionErrors.NotEnoughInputError)
        }
        
        XCTAssertThrowsError(try PaceCalculator(distance: 1), "Too many nil values should report an error") { error in
            XCTAssertEqual(error as! PaceCalculator.SessionErrors, PaceCalculator.SessionErrors.NotEnoughInputError)
        }
        
        XCTAssertThrowsError(try PaceCalculator(pace: 1), "Too many nil values should report an error") { error in
            XCTAssertEqual(error as! PaceCalculator.SessionErrors, PaceCalculator.SessionErrors.NotEnoughInputError)
        }
    }
    
    func testDataInconsistencyError() throws {
        XCTAssertThrowsError(try PaceCalculator(time: 10, distance: 1, pace: 1), "Inconsistent data instantiated should throw an error") { error in
            XCTAssertEqual(error as! PaceCalculator.SessionErrors, PaceCalculator.SessionErrors.DataInconsistencyError)
        }
    }
    
    func testCaculatesTime() throws {
        ///Instantiating with distance 10km and pace 1km/second
        let paceCalculator = try PaceCalculator(distance: 10, pace: 1)
        
        let calculatedResult = paceCalculator.generateData().time
        
        ///Representing 10s
        let expectedResult = 10.0
        
        XCTAssertEqual(calculatedResult, expectedResult)
    }
    
    func testCaculatesDistance() throws {
        ///Instantiating with time 10s and pace 1km/second
        let paceCalculator = try PaceCalculator(time: 10, pace: 1)
        
        let calculatedResult = paceCalculator.generateData().distance
        
        ///Representing 10km
        let expectedResult = 10.0
        
        XCTAssertEqual(calculatedResult, expectedResult)
    }
    
    func testCaculatesPace() throws {
        ///Instantiating with time 10s and distance 10km
        let paceCalculator = try PaceCalculator(time: 10, distance: 10)
        
        let calculatedResult = paceCalculator.generateData().pace
        
        ///Representing 1km/s
        let expectedResult = 1.0
        
        XCTAssertEqual(calculatedResult, expectedResult)
    }
    
    func testReturnsDataForAllInput() throws {
        let paceCalculator = try PaceCalculator(time: 1, distance: 1, pace: 1)
        
        let calculatedResult = paceCalculator.generateData()
        
        let expectedResult = 1.0
        
        XCTAssertEqual(calculatedResult.time, expectedResult)
        XCTAssertEqual(calculatedResult.distance, expectedResult)
        XCTAssertEqual(calculatedResult.pace, expectedResult)
    }
}
