//
//  UserDefaultsManager.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 26/01/22.
//

import Foundation

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
}

extension UserDefaultsScoreStorage {
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
