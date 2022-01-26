//
//  PlayerTests.swift
//  ConnectFourTests
//
//  Created by Cristhian Leon on 26/01/22.
//

import XCTest
@testable import ConnectFour

class PlayerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_DisplayTileImage_GivenYellowValues_ShouldMatch() {
        // Given
        let player = Player(name: "name", color: .yellow, managedByAI: false)
        
        // When
        let result = player.displayTileImage
        
        // Then
        XCTAssertEqual(result, UIImage(named: "yellow_tile"))
    }
    
    func test_DisplayTileImage_GivenRedValues_ShouldMatch() {
        // Given
        let player = Player(name: "name", color: .red, managedByAI: false)
        
        // When
        let result = player.displayTileImage
        
        // Then
        XCTAssertEqual(result, UIImage(named: "red_tile"))
    }
}
