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
    
    var playButtonTitle: String {
        // TODO: Localize
        return "Play"
    }
    
    var titleLabel: String {
        // TODO: Localize
        return "Ready for some fun?"
    }
    
    var subtitleLabel: String {
        // TODO: Localize
        return "This app is the 1st. monthly code challenge proposed by @MoureDev."
    }
}
