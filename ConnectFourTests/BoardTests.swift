//
//  BoardTests.swift
//  ConnectFourTests
//
//  Created by Cristhian Leon on 25/01/22.
//

import XCTest
@testable import ConnectFour

class BoardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_BoardCreation_GivenSize_ShouldMatchItemCount() {
        // Given
        let width = 7
        let height = 6
        
        // When
        let board: Board<Int> = Board(width: width, height: height)
        
        // Then
        XCTAssertEqual(board.columnCount, width)
        XCTAssertEqual(board.rowCount, height)
    }
    
    func test_BoardCreation_GivenSize_ShouldAllBeNil() {
        // Given
        let width = 7
        let height = 6
        
        // When
        let board: Board<Int> = Board(width: width, height: height)
        
        // Then
        for column in board.items{
            for item in column {
                XCTAssertNil(item)
            }
        }
    }
    
    func test_ItemCount_GivenSize_ShouldMatchCount() {
        // Given
        let width = 7
        let height = 6
        
        // When
        let board: Board<Int> = Board(width: width, height: height)
        
        // Then
        XCTAssertEqual(board.columnCount, width)
        XCTAssertEqual(board.rowCount, height)
    }
    
    func test_GetItem_GivenWrongIndices_ShouldBeNil() {
        // Given
        let width = 7
        let height = 6
        
        // When
        let board: Board<Int> = Board(width: width, height: height)
        
        // Then
        XCTAssertNil(board.getItem(at: VectorInt(x: -1, y: 0)))
        XCTAssertNil(board.getItem(at: VectorInt(x: width, y: 0)))
        
        XCTAssertNil(board.getItem(at: VectorInt(x: 0, y: -1)))
        XCTAssertNil(board.getItem(at: VectorInt(x: 0, y: height)))
    }
    
    func test_GetItem_GivenRightIndicesAndValues_ShouldNotBeNil() {
        // Given
        let width = 7
        let height = 6
        
        // When
        let board: Board<Int> = Board(width: width, height: height)
        board.addTile(value: 1, toColumn: 0)
        
        // Then
        XCTAssertNotNil(board.getItem(at: VectorInt(x: 0, y: 5)))
    }
    
    func test_AddTile_GivenValues_ShouldNotBeNil() {
        // Given
        let width = 7
        let height = 6
        
        // When
        let board: Board<Int> = Board(width: width, height: height)
        
        // Then
        board.addTile(value: 1, toColumn: 0)
        XCTAssertEqual(board.getItem(at: VectorInt(x: 0, y: 5)), 1)
        
        board.addTile(value: 2, toColumn: 1)
        XCTAssertEqual(board.getItem(at: VectorInt(x: 1, y: 5)), 2)
    }
    
    func test_IsFull_GivenFullMatrix_ShouldBeTrue() {
        // Given
        let width = 7
        let height = 6
        
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        for column in 0..<width {
            for _ in 0..<height {
                board.addTile(value: 1, toColumn: column)
            }
        }
        
        // Then
        XCTAssertTrue(board.isFull)
    }
    
    func test_IsFull_GivenNonFullMatrix_ShouldBeFalse() {
        // Given
        let width = 7
        let height = 6
        
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        for column in 0..<width-1 {
            for _ in 0..<height {
                board.addTile(value: 1, toColumn: column)
            }
        }
        
        // Then
        XCTAssertFalse(board.isFull)
    }
}
