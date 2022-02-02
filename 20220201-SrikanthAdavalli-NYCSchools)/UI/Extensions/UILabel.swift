//
//  UILabel.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import UIKit

extension UILabel {
    enum Style {
        case primary
        case secondary
        case description
    }
    
    convenience init(_ style: Style, numberOfLines: Int = 0, textColor: UIColor = .label, alignment: NSTextAlignment = .natural) {
        self.init()
        
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        self.textAlignment = alignment
        
        switch style {
        case .primary:
            self.numberOfLines = 1
            self.textAlignment = .center
            self.font = .boldSystemFont(ofSize: 17)
        case .secondary:
            self.font = .boldSystemFont(ofSize: 14)
        case .description:
            self.font = .systemFont(ofSize: 14)
        }
        
        self.numberOfLines = numberOfLines
        self.sizeToFit()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
