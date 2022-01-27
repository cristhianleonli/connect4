//
//  MainViewMOdel.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import Foundation

final class MainViewModel {
    
    // MARK: Properties
    
    private let coordinator: MainCoordinator
    
    enum GameType {
        case single
        case multiplayer
    }
    
    // MARK: Life cycle
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
}

extension MainViewModel {
    func showGameView(gameType: GameType) {
        coordinator.showGameView(gameType: gameType)
    }
    
    // TODO: Localize
    
    var playButtonTitle: String {
        return "Play"
    }
    
    var titleLabel: String {
        return "Ready for some fun?"
    }
    
    var subtitleLabel: String {
        return "This app is the 1st. monthly code challenge proposed by @MoureDev."
    }
}
