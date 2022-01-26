//
//  GameConfigurationTests.swift
//  ConnectFourTests
//
//  Created by Cristhian Leon on 26/01/22.
//

import XCTest
@testable import ConnectFour

class GameConfigurationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_BoardWidth_GivenValues_ShouldMatch() {
        // Given
        let size = SizeInt(width: 10, height: 10)
        let config = GameConfiguration(size: size, gameMode: .single)
        
        // When
        let width = config.boardWidth
        let height = config.boardHeight
        
        // Then
        XCTAssertEqual(width, size.width)
        XCTAssertEqual(height, size.height)
    }
}
