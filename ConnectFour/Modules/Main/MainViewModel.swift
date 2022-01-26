//
//  MainViewMOdel.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import Foundation

final class MainViewModel {
    
    private let coordinator: MainCoordinator
    private let container: MainContainer
    
    enum GameType {
        case single
        case multiplayer
    }
    
    init(coordinator: MainCoordinator, container: MainContainer) {
        self.coordinator = coordinator
        self.container = container
    }
}

extension MainViewModel {
    func showGameView(gameType: GameType) {
        coordinator.showGameView(gameType: gameType)
    }
    
    func showInfoView() {
        coordinator.showInfoView()
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
