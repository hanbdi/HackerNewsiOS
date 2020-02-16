//
//  UIColor.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red range, should be 0 <= value <= 255")
        assert(green >= 0 && green <= 255, "Invalid green range, should be 0 <= value <= 255")
        assert(blue >= 0 && blue <= 255, "Invalid blue range, should be 0 <= value <= 255")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF,
           alpha: alpha
        )
    }
 
    static let navigationBar = UIColor(rgb: 0xFF6601)
}
