//
//  TrackTests.swift
//  SmikeTests
//
//  Created by Ryan Koopmans on 12/9/21.
//

import XCTest
@testable import Smike

class TrackTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDistance() throws {
        let track1 = Track(dots: [(position: CGPoint(x: 0, y: 0), depth: 0),
                                 (position: CGPoint(x: 10, y: 0), depth: 0)])
        XCTAssertEqual(track1.distance, 10)
        
        let track2 = Track(dots: [(position: CGPoint(x: 0, y: 0), depth: 0),
                                 (position: CGPoint(x: 0, y: 10), depth: 0)])
        XCTAssertEqual(track2.distance, 10)

        let track3 = Track(dots: [(position: CGPoint(x: 0, y: 0), depth: 0),
                                  (position: CGPoint(x: 10, y: 10), depth: 0)])
        XCTAssertEqual(track3.distance, sqrt(200), accuracy: 0.0001)
        
        let track4 = Track(dots: [(position: CGPoint(x: 0, y: 0), depth: 0),
                                  (position: CGPoint(x: 10, y: 0), depth: 0),
                                  (position: CGPoint(x: 10, y: 10), depth: 0)])
        XCTAssertEqual(track4.distance, 20)
    }
}

