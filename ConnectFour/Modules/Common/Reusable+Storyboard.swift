//
//  Reusable+Storyboard.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
        let controller = instantiateViewController(withIdentifier: type.reuseIdentifier)
        
        guard let viewController = controller as? T else {
            fatalError()
        }
        
        return viewController
    }
}
