//
//  AppCoordinator.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: Properties
    
    var navigationController: UINavigationController
    
    private let window: UIWindow
    private let mainCoordinator: MainCoordinator
    
    // MARK: Life cycle
    
    init(_ window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        mainCoordinator = MainCoordinator(navigationController)
    }
}

// MARK: Navigation

extension AppCoordinator {
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        coordinate(to: mainCoordinator)
    }
}
