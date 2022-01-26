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
    @IBAction
    func navigateBack(_ sender: UIButton) {
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Resume", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
        }))
        
        alert.addAction(UIAlertAction(title: "Main Menu", style: .default , handler:{ (UIAlertAction)in
            self.viewModel.navigateBack()
        }))
        
        alert.addAction(UIAlertAction(title: "Restart", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        self.present(alert, animated: true)
    }
    
    func setupUI() {
        // no color, just the round corner container view
        boardContainer.clipsToBounds = true
        boardContainer.layer.cornerRadius = 15
        
        // inside board, where color is darker
        boardInsideView.backgroundColor = Colors.darkBoard
        
        // convert views into objects
        extractBoardTiles()
        
        // score view, where names and points are displayed
        scoreView.setupUI()
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
                print("game has finished. Winner: \(winner?.id)")
            }
        }
        .store(in: &viewModel.cancellables)
    }
    
    @IBAction
    func playerWantsToMove(_ sender: UIButton) {
        // TODO: implement
        viewModel.playerWantsToMove(column: Int.random(in: 0...6))
    }
    
    @IBAction
    func deleteScoresButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle:  .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
        }))
        
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive , handler:{ (UIAlertAction)in
            self.viewModel.deleteSavedData()
            self.refreshUI()
        }))
        
        self.present(alert, animated: true)
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
