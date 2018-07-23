//
//  Fonts.swift
//  weather
//
//  Created by Wagner De Paula on 7/21/18.
//

import UIKit

enum Font: String {
    case bold       = "IBMPlexSans-Bold"
    case medium     = "IBMPlexSans-Medium"
    case regular    = "IBMPlexSans"
    case light      = "IBMPlexSans-Light"
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}


