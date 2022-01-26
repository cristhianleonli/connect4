//
//  ScoreStorage.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 26/01/22.
//

import Foundation

protocol ScoreStorage: AnyObject {
    var youScore: Int { get }
    var otherScore: Int { get }
    
    func increaseYouScore(by amount: Int)
    func increaseOtherScore(by amount: Int)
    func clearYouScore()
    func clearOtherStore()
    func clearScores()
}

extension ScoreStorage {
    func clearScores() {
        clearYouScore()
        clearOtherStore()
    }
}
