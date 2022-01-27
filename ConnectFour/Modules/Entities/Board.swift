//
//  Board.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import Foundation

final class Board<T> where T: Comparable {
    
    // MARK: Properties
    
    private var matrix: [[T?]]
    
    // MARK: Life cycle
    
    init(width: Int, height: Int) {
        var temp: [[T?]] = []
        
        for _ in 0..<width {
            temp.append([T?].init(repeating: nil, count: height))
        }
        
        matrix = temp
    }
}

extension Board {
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
            print("Trying to access a position that doesn't exist")
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
            if let winner = findAdjancentElements(list: column.compactMap({ $0 })) {
                return winner
            }
        }
        
        // check horizontally, in this case, nils cannot be taken out, because
        // spaces between columns are valid to check whether there's a winner or not
        for index in 0..<matrix[0].count {
            // vertical items in a single list
            let list = matrix.map({ $0[index] })
            
            if let winner = findAdjancentElements(list: list) {
                return winner
            }
        }
        
        // check diagonally
        let items = 3
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                
                if matrix[i][j] == nil {
                    continue
                }
                
                var found = false
                
                // up-right +x -y. This also works as down-left
                if i + items < matrix.count && j - items >= 0 {
                    var x = i
                    var y = j
                    var pivot = matrix[x][y]
                    found = true
                    
                    while x <= i + items, y >= j - items {
                        if matrix[x][y] != pivot {
                            found = false
                            break
                        }
                        
                        pivot = matrix[x][y]
                        
                        x += 1
                        y -= 1
                    }
                }
                
                if found {
                    return matrix[i][j]
                }
                
                // down-right +x +y. This also works as up-left
                if i + items < matrix.count && j + items < matrix[i].count {
                    var x = i
                    var y = j
                    var pivot = matrix[x][y]
                    found = true
                    
                    while x <= i + items, y <= j + items {
                        if matrix[x][y] != pivot {
                            found = false
                            break
                        }
                        
                        pivot = matrix[x][y]
                        
                        x += 1
                        y += 1
                    }
                }
                
                if found {
                    return matrix[i][j]
                }
            }
        }
        
        return nil
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
    
    func findAdjancentElements(list: [T?]) -> T? {
        var adjacentCount = 1
        var previous: T?
        
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
        
        return nil
    }
}
