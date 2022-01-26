//
//  GameViewModel.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import Combine
import Foundation

class GameViewModel: ObservableObject {
    
    private let coordinator: GameCoordinator
    private let container: GameContainer
    private let gameMode: GameConfiguration.GameMode
    private let gameConfig: GameConfiguration
    
    private let youPlayer: Player
    private let otherPlayer: Player
    private var currentPlayer: Player
    
    private(set) var board: Board<String>
    
    var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var currentState: GameState
    
    enum GameState {
        case idle(Player)
        case rendering(Int)
        case finished(Player?)
    }
    
    init(coordinator: GameCoordinator, container: GameContainer, configuration: GameConfiguration) {
        self.coordinator = coordinator
        self.container = container
        self.gameConfig = configuration
        
        // board initialization
        self.board = Board(width: configuration.boardWidth, height: configuration.boardHeight)
        self.gameMode = configuration.gameMode
        
        // players creation
        let playerWearsYellow = Bool.random()
        
        let youPlayer = Player(
            name: Self.youPlayerName,
            color: playerWearsYellow ? .yellow : .red,
            managedByAI: false
        )
        
        let otherPlayer = Player(
            name: Self.otherPlayerName(gameMode: gameMode),
            color: playerWearsYellow ? .red : .yellow,
            managedByAI: configuration.gameMode == .single
        )
        
        self.youPlayer = youPlayer
        self.otherPlayer = otherPlayer
        self.currentPlayer = youPlayer
        self.currentState = .idle(currentPlayer)
    }
}

extension GameViewModel {
    func navigateBack() {
        coordinator.navigateBack()
    }
    
    func findPlayer(by id: String) -> Player? {
        return players.first(where: { $0.id == id })
    }
    
    func playerWantsToMove(column: Int) {
        board.addTile(value: currentPlayer.id, toColumn: column)
        currentState = .rendering(column)
    }
    
    func postMovingChecks() {
        if board.hasWinner {
            endGame(winner: currentPlayer)
        } else if board.isFull {
            endGame(winner: nil)
        } else {
            endTurn()
        }
    }
    
    func restart() {
        self.board = Board(width: gameConfig.boardWidth, height: gameConfig.boardHeight)
    }
    
    func deleteSavedData() {
        container.scoreStorage.clearScores()
    }
    
    var scoreViewModel: ScoreViewModel {
        return ScoreViewModel(
            leftScore: "\(container.scoreStorage.youScore)",
            rightScore: "\(container.scoreStorage.otherScore)",
            leftPlayer: youPlayer,
            rightPlayer: otherPlayer,
            turn: currentPlayer == youPlayer ? .left : .right
        )
    }
    
    var hasMadeMoves: Bool {
        return board.isEmpty == false
    }
    
    var deleteAlertTitle: String {
        // TODO: Localize
        return "Careful!"
    }
    
    var deleteAlertSubtitle: String {
        // TODO: Localize
        return "This action deletes all stored data about previous games. What would you like to do?"
    }
    
    var cancelAction: String {
        // TODO: Localize
        return "Cancel"
    }
    
    var deleteAction: String {
        // TODO: Localize
        return "Clear data"
    }
    
    var mainMenuAction: String {
        // TODO: Localize
        return "Home"
    }
    
    var restartAction: String {
        // TODO: Localize
        return "Restart"
    }
    
    var leaveAlertTitle: String {
        // TODO: Localize
        return "You are about to leave."
    }
    
    var restartAlertTitle: String {
        // TODO: Localize
        return "You are about to restart."
    }
    
    var leaveAlertSubtitle: String {
        // TODO: Localize
        return "The progress of this game will be lost. What would you like to do?"
    }
    
    var leaveAction: String {
        // TODO: Localize
        return "Leave"
    }
}

private extension GameViewModel {
    
    var managedByAI: Bool {
        return gameMode == .single
    }
    
    var players: [Player] {
        return [youPlayer, otherPlayer]
    }
    
    func endGame(winner: Player?) {
        if let winner = winner {
            if winner == youPlayer {
                container.scoreStorage.increaseYouScore(by: 1)
            } else {
                container.scoreStorage.increaseOtherScore(by: 1)
            }
        }
        
        currentState = .finished(winner)
    }
    
    func endTurn() {
        guard var currentIndex = players.firstIndex(where: { $0.id == currentPlayer.id }) else {
            return
        }
        
        currentIndex = (currentIndex + 1) % players.count
        currentPlayer = players[currentIndex]
        currentState = .idle(currentPlayer)
    }
    
    static func otherPlayerName(gameMode: GameConfiguration.GameMode) -> String {
        // TODO: Localize
        switch gameMode {
        case .single: return "PC"
        case .multiplayer: return "Friend"
        }
    }
    
    static var youPlayerName: String {
        // TODO: Localize
        return "You"
    }
}
