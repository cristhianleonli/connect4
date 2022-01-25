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
    
    // MARK: Properties
    
    var viewModel: GameViewModel!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
    }
}
