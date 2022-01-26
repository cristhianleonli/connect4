//
//  ScoreViewModelTests.swift
//  ConnectFourTests
//
//  Created by Cristhian Leon on 26/01/22.
//

import XCTest
@testable import ConnectFour

class ScoreViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Items_GivenRightPlayerRightTurn_ShouldMatch() {
        // Given
        let leftPlayer = Player(name: "left", color: .red, managedByAI: false)
        let rightPlayer = Player(name: "right", color: .yellow, managedByAI: false)
        
        let viewModel = ScoreViewModel(
            leftScore: "1",
            rightScore: "2",
            leftPlayer: leftPlayer,
            rightPlayer: rightPlayer,
            turn: .right
        )
        
        // When
        let rightName = viewModel.rightName
        let rightImage = viewModel.rightImage
        let rightIndicatorColor = viewModel.rightIndicatorColor
        
        let leftName = viewModel.leftName
        let leftImage = viewModel.leftImage
        let leftIndicatorColor = viewModel.leftIndicatorColor
        
        // Then
        XCTAssertEqual(rightName, "right")
        XCTAssertEqual(rightImage, UIImage(named: "yellow_tile"))
        XCTAssertEqual(rightIndicatorColor, Colors.yellowTile)
        
        XCTAssertEqual(leftName, "left")
        XCTAssertEqual(leftImage, UIImage(named: "red_tile"))
        XCTAssertEqual(leftIndicatorColor, UIColor.clear)
    }
    
    func test_Items_GivenRightPlayerLeftTurn_ShouldMatch() {
        // Given
        let leftPlayer = Player(name: "left", color: .red, managedByAI: false)
        let rightPlayer = Player(name: "right", color: .yellow, managedByAI: false)
        
        let viewModel = ScoreViewModel(
            leftScore: "1",
            rightScore: "2",
            leftPlayer: leftPlayer,
            rightPlayer: rightPlayer,
            turn: .left
        )
        
        // When
        let rightName = viewModel.rightName
        let rightImage = viewModel.rightImage
        let rightIndicatorColor = viewModel.rightIndicatorColor
        
        let leftName = viewModel.leftName
        let leftImage = viewModel.leftImage
        let leftIndicatorColor = viewModel.leftIndicatorColor
        
        // Then
        XCTAssertEqual(rightName, "right")
        XCTAssertEqual(rightImage, UIImage(named: "yellow_tile"))
        XCTAssertEqual(rightIndicatorColor, UIColor.clear)
        
        XCTAssertEqual(leftName, "left")
        XCTAssertEqual(leftImage, UIImage(named: "red_tile"))
        XCTAssertEqual(leftIndicatorColor, Colors.redTile)
    }
    
    func test_Score_GivenPlayerValues_ShouldMatch() {
        // Given
        let leftPlayer = Player(name: "left", color: .red, managedByAI: false)
        let rightPlayer = Player(name: "right", color: .yellow, managedByAI: false)
        
        let viewModel = ScoreViewModel(
            leftScore: "1",
            rightScore: "2",
            leftPlayer: leftPlayer,
            rightPlayer: rightPlayer,
            turn: .left
        )
        
        // When
        let score = viewModel.score
        
        // Then
        XCTAssertEqual(score, "1:2")
    }
}
