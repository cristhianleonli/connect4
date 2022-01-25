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
    
    init(coordinator: MainCoordinator, container: MainContainer) {
        self.coordinator = coordinator
        self.container = container
    }
}
