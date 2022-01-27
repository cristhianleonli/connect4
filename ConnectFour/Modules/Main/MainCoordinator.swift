//
//  MainCoordinator.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(_ navController: UINavigationController) {
        navigationController = navController
    }
    
    func start() {
        let viewModel = MainViewModel(coordinator: self)
        
        let viewController: MainViewController = UIStoryboard.main.instantiateViewController()
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showGameView(gameType: MainViewModel.GameType) {
        GameCoordinator(navigationController).start()
    }
}
