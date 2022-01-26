//
//  UserDefaultsManager.swift
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

class UserDefaultsScoreStorage: ScoreStorage {
    
    private let youScoreKey: String = "YOU_SCORE"
    private let otherScoreKey: String = "OTHER_SCORE"
    
    var youScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: youScoreKey)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: youScoreKey)
        }
    }
    
    var otherScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: otherScoreKey)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: otherScoreKey)
        }
    }
    
    func increaseYouScore(by amount: Int) {
        youScore += amount
    }
    
    func increaseOtherScore(by amount: Int) {
        otherScore += amount
    }
    
    func clearYouScore() {
        youScore = 0
    }
    
    func clearOtherStore() {
        otherScore = 0
    }
}
