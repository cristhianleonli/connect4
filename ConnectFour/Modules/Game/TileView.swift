//
//  TileView.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

final class TileView: UIView {
    
    // MARK: Properties
    
    // MARK: Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func markAsSelected(color: Player.TileColor) {
        backgroundColor = color.uiColor
    }
    
    func markAsUnselected() {
        backgroundColor = Colors.darkBoard
    }
}
