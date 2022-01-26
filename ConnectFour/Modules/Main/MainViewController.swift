//
//  ViewController.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private var playButton: UIButton!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    var viewModel: MainViewModel!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        localizeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

private extension MainViewController {
    @IBAction
    func playButtonTapped(_ sender: Any) {
        viewModel.showGameView(gameType: .single)
    }
    
    @IBAction
    func infoButtonTapped(_ sender: Any) {
        viewModel.showInfoView()
    }
    
    func setupUI() {
        view.backgroundColor = Colors.mainBackground
        
        // main button
        playButton.backgroundColor = Colors.mainButton
        playButton.layer.cornerRadius = 10
        playButton.setTitleColor(.white, for: .normal)
        playButton.titleLabel?.textColor = .white
        playButton.titleLabel?.font = Fonts.averta(weight: .semibold, size: 20)
        
        // title label
        titleLabel.textColor = .white
        titleLabel.font = Fonts.averta(weight: .semibold, size: 30)
        
        // subtitle label
        subtitleLabel.textColor = .white
        subtitleLabel.font = Fonts.averta(weight: .regular, size: 18)
    }
    
    func localizeUI() {
        playButton.setTitle(viewModel.playButtonTitle, for: .normal)
        titleLabel.text = viewModel.titleLabel
        subtitleLabel.text = viewModel.subtitleLabel
    }
    
    func createGradient() {
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [Colors.gradientStart.cgColor, Colors.gradientEnd.cgColor]
        gradientLayer.shouldRasterize = true
        
        // Apply the gradient to the backgroundGradientView.
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
