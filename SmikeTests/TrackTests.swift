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
      let track1 = Track(orderedDots: [(position: CGPoint(x: 0, y: 0), depth: 0, layer: 0),
                               (position: CGPoint(x: 10, y: 0), depth: 0, layer: 0)])
      XCTAssertEqual(track1.distance, 10)
        
      let track2 = Track(orderedDots: [(position: CGPoint(x: 0, y: 0), depth: 0, layer: 0),
                               (position: CGPoint(x: 0, y: 10), depth: 0, layer: 0)])
      XCTAssertEqual(track2.distance, 10)

      let track3 = Track(orderedDots: [(position: CGPoint(x: 0, y: 0), depth: 0, layer: 0),
                                (position: CGPoint(x: 10, y: 10), depth: 0, layer: 0)])
      XCTAssertEqual(track3.distance, sqrt(200), accuracy: 0.0001)
        
      let track4 = Track(orderedDots: [(position: CGPoint(x: 0, y: 0), depth: 0, layer: 0),
                                (position: CGPoint(x: 10, y: 0), depth: 0, layer: 0),
                                (position: CGPoint(x: 10, y: 10), depth: 0, layer: 0)])
      XCTAssertEqual(track4.distance, 20)
    }
    
    func testPositionAndPointAlong() throws {
      let track1 = Track(orderedDots: [(position: CGPoint(x: 0, y: 0), depth: 0, layer: 0),
                                (position: CGPoint(x: 10, y: 0), depth: 1.0, layer: 0)])
        
      XCTAssertTrue(track1.dotFractionAlong(0.0) == (position: CGPoint(x: 0, y: 0), depth: 0.0, layer: 0))
      XCTAssertTrue(track1.dotFractionAlong(0.5) == (position: CGPoint(x: 5, y: 0), depth: 0.5, layer: 0))
      XCTAssertTrue(track1.dotFractionAlong(1.0) == (position: CGPoint(x: 10, y: 0), depth: 1.0, layer: 0))

      let track2 = Track(orderedDots: [(position: CGPoint(x: 1, y: 1), depth: 0.25, layer: 0),
                                (position: CGPoint(x: 1, y: 3), depth: 0.6, layer: 0),
                                (position: CGPoint(x: 3, y: 5), depth: 0.8, layer: 0)])

      let posAndDepth = track2.dotFractionAlong(0.707)
      XCTAssertEqual(posAndDepth.position.x, 2, accuracy: 0.001)
      XCTAssertEqual(posAndDepth.position.y, 4, accuracy: 0.001)
      XCTAssertEqual(posAndDepth.depth, 0.7, accuracy: 0.0001)
    }
}

