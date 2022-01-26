//
//  Player.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

struct Player {
    
    // MARK: Properties
    
    let id: String = UUID().uuidString
    let name: String
    let color: TileColor
    let managedByAI: Bool
    
    enum TileColor {
        case red
        case yellow
        
        var uiColor: UIColor {
            switch self {
            case .red:
                return Colors.redTile
            case .yellow:
                return Colors.yellowTile
            }
        }
        
        // TODO: Localize
        
        var displayName: String {
            switch self {
            case .red: return "Red"
            case .yellow: return "Yellow"
            }
        }
    }
    
    var displayTileImage: UIImage {
        switch color {
        case .red: return UIImage(named: "red_tile")!
        case .yellow: return UIImage(named: "yellow_tile")!
        }
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return rhs.id == lhs.id
    }
}
