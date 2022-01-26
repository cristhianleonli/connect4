//
//  Board.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import Foundation

class Board<T> {
    
    private var matrix: [[T?]]
    
    init(width: Int, height: Int) {
        var temp: [[T?]] = []
        
        for _ in 0..<width {
            temp.append([T?].init(repeating: nil, count: height))
        }
        
        matrix = temp
    }
    
    func addTile(value: T, toColumn index: Int) {
        let column = matrix[index]
        
        guard column[0] == nil else {
            return
        }
        
        var emptyIndex: Int = column.count - 1
        
        for i in column.indices {
            if column[i] != nil {
                emptyIndex = i - 1
                break
            }
        }
        
        matrix[index][emptyIndex] = value
    }
    
    var items: [[T?]] {
        return matrix
    }
    
    var hasWinner: Bool {
        // TODO: check 4 tiles in a row
        return false
    }
    
    var isFull: Bool {
        for column in matrix {
            for item in column {
                if item == nil {
                    return false
                }
            }
        }
        
        return true
    }
    
    var columnCount: Int {
        return matrix.count
    }
    
    var rowCount: Int {
        return matrix[0].count
    }
    
    var isEmpty: Bool {
        for column in matrix {
            for item in column {
                if item != nil {
                    return false
                }
            }
        }
        
        return true
    }
    
    func getItem(at index: VectorInt) -> T? {
        guard index.x >= 0, index.x < matrix.count else {
            return nil
        }
        
        guard index.y >= 0, index.y < matrix[0].count else {
            return nil
        }
        
        return matrix[index.x][index.y]
    }
}
