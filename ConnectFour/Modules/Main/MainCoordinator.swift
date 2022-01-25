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
        let container = MainContainer()
        let viewModel = MainViewModel(coordinator: self, container: container)
        
        let viewController: MainViewController = UIStoryboard.main.instantiateViewController()
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: .main)
    }
}
