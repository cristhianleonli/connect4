//
//  Storyboard+App.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: .main)
    }
    
    static var game: UIStoryboard {
        return UIStoryboard(name: "Game", bundle: .main)
    }
}
