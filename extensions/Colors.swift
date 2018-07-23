//
//  Colors.swift
//  weather
//
//  Created by Wagner De Paula on 7/21/18.
//

import UIKit

struct Color {
    
    static let black        = UIColor(0x000000)
    static let white        = UIColor(0xffffff)
    static let gray         = UIColor(0x888888)
    static let lightGray    = UIColor(0xeeeeee)
    static let darkGray     = UIColor(0x333333)
    
    static let blue         = UIColor(0x054ada)
    
    static let separator    = UIColor(0xcccccc)
    static let highlight    = UIColor(0xf0f0f0)
}

extension UIColor {
    convenience init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
