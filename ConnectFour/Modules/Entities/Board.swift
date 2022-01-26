//
//  Board.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import Foundation

class Board<T> where T: Comparable {
    
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
            print("Trying to add a tile where there's no more space")
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
    
    func numberOfTiles(at index: Int) -> Int {
        guard index >= 0, index < matrix.count else {
            print("Trying to access a position that doesn't exitst")
            return matrix.count
        }
        
        var count = 0
        
        for item in matrix[index] {
            if item != nil {
                count += 1
            }
        }
        
        return count
    }
    
    func findWinner() -> T? {
        // check vertically, if there are >= 4 adjacent elements
        for column in matrix {
            var adjacentCount = 1
            var previous: T?
            
            // ignore nils, to avoid a winner of tiles
            // iif nil wins, technically there's no winner, but to avoid that
            // compactMap is used here.
            for item in column.compactMap({ $0 }) {
                if previous == nil {
                    previous = item
                    adjacentCount = 1
                } else {
                    if item == previous {
                        adjacentCount += 1
                    } else {
                        adjacentCount = 1
                    }
                    
                    previous = item
                }
                
                // check for a winner in every item iteration
                if adjacentCount >= 4 {
                    return previous
                }
            }
        }
        
        // check horizontally, in this case, nils cannot be taken out, because
        // spaces between columns are valid to check whether there's a winner or not
        for index in 0..<matrix[0].count {
            var adjacentCount = 1
            var previous: T?
            
            // vertical items in a single list
            let list = matrix.map({ $0[index] })
            
            for item in list {
                if previous == nil {
                    previous = item
                    adjacentCount = 1
                } else {
                    if item == previous {
                        adjacentCount += 1
                    } else {
                        adjacentCount = 1
                    }

                    previous = item
                }
                
                // check for a winner in every item iteration
                if adjacentCount >= 4 {
                    return previous
                }
            }
        }
        
        // check diagonally
        return nil
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
