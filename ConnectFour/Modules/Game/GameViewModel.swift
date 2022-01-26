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
        case idle
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
        self.currentState = .idle
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
        guard column >= 0 && column < board.columnCount else {
            return
        }
        
        board.addTile(value: currentPlayer.id, toColumn: column)
        currentState = .rendering(column)
    }
    
    func postMovingChecks() {
        if let winner = board.findWinner() {
            if winner == currentPlayer.id {
                endGame(winner: currentPlayer)
            }
        } else if board.isFull {
            endGame(winner: nil)
        } else {
            endTurn()
        }
    }
    
    func canAddTiles(at index: Int) -> Bool {
        return board.numberOfTiles(at: index) < board.rowCount
    }
    
    func restart() {
        currentPlayer = youPlayer
        self.currentState = .idle
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
    
    // TODO: Localize
    
    var deleteAlertTitle: String {
        return "Careful!"
    }
    
    var deleteAlertSubtitle: String {
        return "This action deletes all stored data about previous games. What would you like to do?"
    }
    
    var cancelAction: String {
        return "Cancel"
    }
    
    var deleteAction: String {
        return "Clear data"
    }
    
    var mainMenuAction: String {
        return "Home"
    }
    
    var restartAction: String {
        return "Restart"
    }
    
    var leaveAlertTitle: String {
        return "You are about to leave."
    }
    
    var restartAlertTitle: String {
        return "You are about to restart."
    }
    
    var leaveAlertSubtitle: String {
        return "The progress of this game will be lost. What would you like to do?"
    }
    
    var leaveAction: String {
        return "Leave"
    }
    
    func winnerAlertPlayer(_ winner: String) -> String {
        return "\(winner) wins!!"
    }
    
    var winnerAlertTitle: String {
        return "Game over"
    }
    
    var winnerAlertDraw: String {
        return "Draw"
    }
    
    var dismissAction: String {
        return "Dismiss"
    }
    
    var playAgainAction: String {
        return "Play again"
    }
    
    var homeButton: String {
        return "Home"
    }
    
    var restartButton: String {
        return "Restart"
    }
    
    var clearButton: String {
        return "Clear"
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
        currentState = .idle
    }
    
    // TODO: Localize
    
    static func otherPlayerName(gameMode: GameConfiguration.GameMode) -> String {
        switch gameMode {
        case .single: return "PC"
        case .multiplayer: return "Friend"
        }
    }
    
    static var youPlayerName: String {
        return "You"
    }
}
