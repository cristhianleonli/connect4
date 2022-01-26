//
//  AppCoordinator.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    private let window: UIWindow
    private let mainCoordinator: MainCoordinator
    
    init(_ window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        mainCoordinator = MainCoordinator(navigationController)
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        startApp()
    }
    
    private func startApp() {
        coordinate(to: mainCoordinator)
    }
}
