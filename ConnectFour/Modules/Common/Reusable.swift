//
//  Reusable.swift
//  ConnectFour
//
//  Created by Cristhian Leon on 25/01/22.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: Reusable { }
extension UICollectionViewCell: Reusable { }
extension UITableViewCell: Reusable { }
extension UIViewController: Reusable { }
