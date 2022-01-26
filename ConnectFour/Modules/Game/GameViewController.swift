//
//  GameViewController.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var boardContainer: UIView!
    @IBOutlet private weak var boardInsideView: UIView!
    @IBOutlet private weak var tilesContainer: UIStackView!
    @IBOutlet private weak var scoreView: ScoreView!
    
    @IBOutlet private weak var homeButton: MainButton!
    @IBOutlet private weak var restartButton: MainButton!
    @IBOutlet private weak var clearButton: MainButton!
    
    // MARK: Properties
    
    var viewModel: GameViewModel!
    private var tiles: [[TileView]] = []
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

private extension GameViewController {
    func navigateBack() {
        if viewModel.hasMadeMoves {
            let alert = UIAlertController(
                title: viewModel.leaveAlertTitle,
                message: viewModel.leaveAlertSubtitle,
                preferredStyle:  .alert
            )
            
            alert.addAction(UIAlertAction(title: viewModel.cancelAction, style: .default , handler: { (UIAlertAction) in
            }))
            
            alert.addAction(UIAlertAction(title: viewModel.leaveAction, style: .destructive , handler: { [weak self] (UIAlertAction)  in
                self?.viewModel.navigateBack()
            }))
            
            self.present(alert, animated: true)
        } else {
            self.viewModel.navigateBack()
        }
    }
    
    func setupUI() {
        view.backgroundColor = Colors.gameBackground
        // no color, just the round corner container view
        boardContainer.clipsToBounds = true
        boardContainer.layer.cornerRadius = 15
        
        // inside board, where color is darker
        boardInsideView.backgroundColor = Colors.darkBoard
        
        // convert views into objects
        extractBoardTiles()
        
        // score view, where names and points are displayed
        scoreView.setupUI()
        
        homeButton.setup(title: "Home", image: UIImage(named: "home")!, action: self.navigateBack)
        restartButton.setup(title: "Restart", image: UIImage(named: "restart")!, action: self.restart)
        clearButton.setup(title: "Clear", image: UIImage(named: "clear")!, action: self.deleteStoredData)
    }
    
    func extractBoardTiles() {
        tiles = []
        
        for container in tilesContainer.arrangedSubviews.compactMap({ $0 as? UIStackView }) {
            tiles.append(container.subviews.compactMap({ $0 as? TileView }))
        }
    }
    
    func bindViews() {
        viewModel.$currentState.sink { state in
            switch state {
            case .idle(let player):
                print("waiting for player \(player.id) to move")
                self.refreshUI()
            case .rendering(let column):
                print("rendering move at: \(column)")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.drawBoard()
                    self.viewModel.postMovingChecks()
                }
            case .finished(let winner):
                print("game has finished. Winner: \(winner?.id ?? "no winner")")
            }
        }
        .store(in: &viewModel.cancellables)
    }
    
    @IBAction
    func playerWantsToMove(_ sender: UIButton) {
        // TODO: implement
        viewModel.playerWantsToMove(column: Int.random(in: 0...6))
    }
    
    func deleteStoredData() {
        let alert = UIAlertController(
            title: viewModel.deleteAlertTitle,
            message: viewModel.deleteAlertSubtitle,
            preferredStyle:  .alert
        )
        
        alert.addAction(UIAlertAction(title: viewModel.cancelAction, style: .default , handler: { (UIAlertAction)in
        }))
        
        alert.addAction(UIAlertAction(title: viewModel.deleteAction, style: .destructive , handler: { (UIAlertAction)in
            self.viewModel.deleteSavedData()
            self.refreshUI()
        }))
        
        self.present(alert, animated: true)
    }
    
    func restart() {
        if viewModel.hasMadeMoves {
            let alert = UIAlertController(
                title: viewModel.restartAlertTitle,
                message: viewModel.leaveAlertSubtitle,
                preferredStyle:  .alert
            )
            
            alert.addAction(UIAlertAction(title: viewModel.cancelAction, style: .default , handler: { (UIAlertAction) in
            }))
            
            alert.addAction(UIAlertAction(title: viewModel.restartAction, style: .destructive , handler: { [weak self] (UIAlertAction)  in
                self?.viewModel.restart()
                self?.refreshUI()
            }))
            
            self.present(alert, animated: true)
        } else {
            self.viewModel.restart()
            self.refreshUI()
        }
    }
    
    func refreshUI() {
        drawBoard()
        refreshScoreView()
    }
    
    func refreshScoreView() {
        let scoreViewModel = viewModel.scoreViewModel
        scoreView.updateUI(model: scoreViewModel)
    }
    
    func drawBoard() {
        for i in 0..<viewModel.board.columnCount {
            for j in 0..<viewModel.board.rowCount {
                let position = VectorInt(x: i, y: j)
                
                if let playerId = viewModel.board.getItem(at: position),
                   let player = viewModel.findPlayer(by: playerId) {
                    
                    // find the player that matches with the id on the matrix
                    tiles[i][j].markAsSelected(color: player.color)
                } else {
                    // if no player found whatsoever, mark the cell as unselected
                    tiles[i][j].markAsUnselected()
                }
            }
        }
    }
}
