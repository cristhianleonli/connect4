//
//  ViewController.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private var onePlayerButton: UIButton!
    @IBOutlet private var twoPlayerButton: UIButton!
    
    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension MainViewController {
    @IBAction
    func onePlayerButtonTapped(_ sender: Any) {
        viewModel.showGameView(gameType: .single)
    }
    
    @IBAction
    func twoPlayersButtonTapped(_ sender: Any) {
        viewModel.showGameView(gameType: .multiplayer)
    }
}
