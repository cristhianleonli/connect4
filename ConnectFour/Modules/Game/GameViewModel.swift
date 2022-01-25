//
//  GameViewModel.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import Foundation

final class GameViewModel {
    
    private let coordinator: GameCoordinator
    private let container: GameContainer
    
    enum GameType {
        case single
        case multiplayer
    }
    
    init(coordinator: GameCoordinator, container: GameContainer) {
        self.coordinator = coordinator
        self.container = container
    }
}

extension GameViewModel {
    func navigateBack() {
        coordinator.navigateBack()
    }
}
