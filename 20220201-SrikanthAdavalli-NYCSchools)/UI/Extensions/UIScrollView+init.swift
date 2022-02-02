//
//  UIScrollView+init.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/2/22.
//

import Foundation
import UIKit

extension UIScrollView {
    convenience init(showsVerticalScrollIndicator: Bool) {
        self.init()
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
