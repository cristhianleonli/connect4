//
//  GameCoordinator.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

final class GameCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(_ navController: UINavigationController) {
        navigationController = navController
    }
    
    func start() {
        // dependencies required by viewModel to work properly
        let container = GameContainer(scoreStorage: UserDefaultsScoreStorage())
        
        // game type is hard-coded here, letting the code accept single-player/AI game modes.
        // Eventhough the game mode is flexible, the logic isn't. If AI is added, it requried some
        // logic changes on the viewModel. But for the scope, multiplayer is good enough
        let gameConfig = GameConfiguration(size: SizeInt(width: 7, height: 6), gameMode: .multiplayer)
        let viewModel = GameViewModel(coordinator: self, container: container, configuration: gameConfig)
        
        let viewController: GameViewController = UIStoryboard.game.instantiateViewController()
        viewController.viewModel = viewModel
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        navigationController.present(viewController, animated: true)
    }
    
    func navigateBack() {
        navigationController.dismiss(animated: true)
    }
}
