//
//  SpotView.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

final class SpotView: UIView {
    
    // MARK: Properties
    
    // space between the border and the circle mask
    private let padding: CGFloat = 5
    
    // MARK: Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = Colors.board
        updateMask()
    }
}

private extension SpotView {
    /// Cuts a circle out of the view, to make the effect of the board
    func updateMask() {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        let radius: CGFloat = frame.width / 2
        
        // start from a little offet out of the view border
        let rect = CGRect(
            x: padding,
            y: padding,
            width: 2 * radius - 2 * padding,
            height: 2 * radius - 2 * padding
        )
        
        let circlePath = UIBezierPath(ovalIn: rect)
        
        // Create the bezier path
        let path = UIBezierPath(rect: bounds)
        path.append(circlePath)
        maskLayer.fillRule = .evenOdd
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
