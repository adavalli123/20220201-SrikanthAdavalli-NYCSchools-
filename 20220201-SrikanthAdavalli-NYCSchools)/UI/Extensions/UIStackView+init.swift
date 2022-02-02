//
//  UIStackView+init.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/2/22.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init(spacing: CGFloat = 0, axis: NSLayoutConstraint.Axis) {
        self.init()
        self.axis = axis
        distribution = .fill
        alignment = .fill
        translatesAutoresizingMaskIntoConstraints = false
        self.spacing = spacing
    }
}
