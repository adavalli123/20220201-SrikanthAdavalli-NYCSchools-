//
//  UITableViewCell+Identifier.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/2/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return "\(Self.classForCoder())"
    }
}

extension UITableView {
    func registerCell(cell: AnyClass) {
        self.register(cell, forCellReuseIdentifier: UITableViewCell.identifier)
    }
}
