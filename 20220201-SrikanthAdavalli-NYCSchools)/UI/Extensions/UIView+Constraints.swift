//
//  UIView+Constraints.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation
import UIKit

public extension UIView {
    enum Spacing: CaseIterable {
        case `default`
        case none
        
        var offSet: UIOffset {
            switch self {
            case .default:
                return UIOffset(horizontal: 15, vertical: 50)
            case .none:
                return .zero
            }
        }
    }
    
    func add(view: UIView, spacing: Spacing = .none) {
        addSubview(view)
        view.pinToSuperView(spacing: spacing)
    }
    
    func pinToSuperView(spacing: Spacing = .none) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                topAnchor.constraint(equalTo: superview.topAnchor, constant: spacing.offSet.vertical),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -spacing.offSet.vertical),
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: spacing.offSet.horizontal),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -spacing.offSet.horizontal),
            ]
        )
    }
}
