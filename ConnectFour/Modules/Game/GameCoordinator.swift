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
        let container = GameContainer()
        let viewModel = GameViewModel(coordinator: self, container: container)
        
        let viewController: GameViewController = UIStoryboard.game.instantiateViewController()
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
