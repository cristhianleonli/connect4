//
//  MainButton.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 26/01/22.
//

import Foundation
import UIKit

final class MainButton: UIView {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var wrapperView: UIView!
    
    // MARK: Properties
    
    private var contentView: UIView?
    var onButtonTapped: () -> Void = { }
    
    // MARK: Life cycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func setup(title: String, image: UIImage, action: @escaping () -> Void) {
        // button content
        wrapperView.layer.cornerRadius = 12
        wrapperView.backgroundColor = Colors.gameButton
        wrapperView.clipsToBounds = true
        
        titleLabel.text = title
        imageView.image = image
        
        // save closure for later executions
        self.onButtonTapped = action
        
        // setup ui components
        titleLabel.font = Fonts.averta(weight: .regular, size: 15)
    }
}

private extension MainButton {
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: MainButton.reuseIdentifier, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction
    func buttonTapped() {
        onButtonTapped()
    }
}

