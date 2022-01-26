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
        for column in board.items {
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
    
    func test_IsEmpty_GivenDirtyMatrix_ShouldBeFalse() {
        // Given
        let width = 7
        let height = 6
        
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        board.addTile(value: 1, toColumn: 0)
        
        // Then
        XCTAssertFalse(board.isEmpty)
    }
    
    func test_IsEmpty_GivenEmptyMatrix_ShouldBeTrue() {
        // Given
        let width = 7
        let height = 6
        
        // When
        let board: Board<Int> = Board(width: width, height: height)
        
        // Then
        XCTAssertTrue(board.isEmpty)
    }
    
    func test_NumberOfTiles_GivenDirtyColumn_ShouldMatchValue() {
        // Given
        let width = 7
        let height = 6
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        board.addTile(value: 1, toColumn: 0)
        
        // Then
        XCTAssertEqual(board.numberOfTiles(at: 0), 1)
    }
    
    func test_NumberOfTiles_GivenDirtierColumn_ShouldMatchValue() {
        // Given
        let width = 7
        let height = 6
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        board.addTile(value: 1, toColumn: 0)
        
        board.addTile(value: 1, toColumn: 1)
        board.addTile(value: 1, toColumn: 1)
        
        board.addTile(value: 1, toColumn: 2)
        
        board.addTile(value: 1, toColumn: 3)
        board.addTile(value: 1, toColumn: 3)
        
        // Then
        XCTAssertEqual(board.numberOfTiles(at: 0), 1)
        XCTAssertEqual(board.numberOfTiles(at: 1), 2)
        XCTAssertEqual(board.numberOfTiles(at: 2), 1)
        XCTAssertEqual(board.numberOfTiles(at: 3), 2)
    }
    
    func test_NumberOfTiles_GivenEmptyColumn_ShouldMatchValue() {
        // Given
        let width = 7
        let height = 6
        
        // When
        let board: Board<Int> = Board(width: width, height: height)
        
        // Then
        XCTAssertEqual(board.numberOfTiles(at: 0), 0)
    }
    
    func test_FindWinner_GivenVerticalWinner_ShouldBeTrue() {
        // Given
        let width = 7
        let height = 6
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        board.addTile(value: 1, toColumn: 0)
        board.addTile(value: 1, toColumn: 0)
        board.addTile(value: 1, toColumn: 0)
        board.addTile(value: 1, toColumn: 0)
        
        // Then
        XCTAssertEqual(board.findWinner(), 1)
    }
    
    func test_FindWinner_GivenNoWinner_ShouldBeNil() {
        // Given
        let width = 7
        let height = 6
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        board.addTile(value: 1, toColumn: 0)
        board.addTile(value: 2, toColumn: 0)
        board.addTile(value: 1, toColumn: 0)
        board.addTile(value: 2, toColumn: 0)
        board.addTile(value: 1, toColumn: 0)
        board.addTile(value: 2, toColumn: 0)
        
        // Then
        XCTAssertNil(board.findWinner())
    }
    
    func test_FindWinner_GivenVerticalWinner2_ShouldBe2() {
        // Given
        let width = 7
        let height = 6
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        board.addTile(value: 1, toColumn: 0)
        board.addTile(value: 2, toColumn: 0)
        board.addTile(value: 2, toColumn: 0)
        board.addTile(value: 2, toColumn: 0)
        board.addTile(value: 2, toColumn: 0)
        board.addTile(value: 1, toColumn: 0)
        
        // Then
        XCTAssertEqual(board.findWinner(), 2)
    }
    
    func test_FindWinner_GivenEmptyboard_ShouldBeNil() {
        // Given
        let width = 7
        let height = 6
        
        // When
        let board: Board<Int> = Board(width: width, height: height)
        
        // Then
        XCTAssertNil(board.findWinner())
    }
    
    func test_FindWinner_GivenVerticalWinner2_ShouldMatch() {
        // Given
        let width = 7
        let height = 6
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        board.addTile(value: 1, toColumn: 1)
        board.addTile(value: 2, toColumn: 1)
        board.addTile(value: 2, toColumn: 1)
        board.addTile(value: 2, toColumn: 1)
        board.addTile(value: 2, toColumn: 1)
        board.addTile(value: 1, toColumn: 1)
        
        // Then
        XCTAssertEqual(board.findWinner(), 2)
    }
    
    func test_FindWinner_GivenHorizontalWinner_ShouldMatch() {
        // Given
        let width = 7
        let height = 6
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        board.addTile(value: 1, toColumn: 0)
        board.addTile(value: 2, toColumn: 1)
        board.addTile(value: 2, toColumn: 2)
        board.addTile(value: 2, toColumn: 3)
        board.addTile(value: 2, toColumn: 4)
        board.addTile(value: 1, toColumn: 5)
        board.addTile(value: 1, toColumn: 6)
        
        // Then
        XCTAssertEqual(board.findWinner(), 2)
    }
    
    func test_FindWinner_GivenHorizontalWinner2_ShouldMatch() {
        // Given
        let width = 7
        let height = 6
        let board: Board<Int> = Board(width: width, height: height)
        
        // When
        board.addTile(value: 1, toColumn: 0)
        board.addTile(value: 1, toColumn: 1)
        board.addTile(value: 1, toColumn: 2)
        board.addTile(value: 1, toColumn: 3)
        board.addTile(value: 2, toColumn: 4)
        board.addTile(value: 1, toColumn: 5)
        board.addTile(value: 1, toColumn: 6)
        
        // Then
        XCTAssertEqual(board.findWinner(), 1)
    }
}
