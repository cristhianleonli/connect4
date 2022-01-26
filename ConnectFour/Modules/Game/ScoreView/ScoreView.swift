//
//  ScoreView.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 26/01/22.
//

import Foundation
import UIKit

class ScoreView: UIView {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var rightImageView: UIImageView!
    @IBOutlet private weak var rightNameLabel: UILabel!
    
    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var leftNameLabel: UILabel!
    
    // MARK: Properties
    
    private var contentView: UIView?
    
    // MARK: Life cycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
}

private extension ScoreView {
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: ScoreView.reuseIdentifier, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

extension ScoreView {
    func setupUI() {
        scoreLabel.font = Fonts.averta(weight: .semibold, size: 25)
        
        rightNameLabel.font = Fonts.averta(weight: .semibold, size: 20)
        leftNameLabel.font = Fonts.averta(weight: .semibold, size: 20)
    }
    
    func updateUI(model: ScoreViewModel) {
        scoreLabel.text = "\(model.leftScore):\(model.rightScore)"
        
        leftNameLabel.text = model.leftName
        leftImageView.image = model.leftImage
        
        rightNameLabel.text = model.rightName
        rightImageView.image = model.rightImage
    }
}
