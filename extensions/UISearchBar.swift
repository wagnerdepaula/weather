//
//  UISearchBar.swift
//  weather
//
//  Created by Wagner De Paula on 7/22/18.
//

import UIKit

extension UISearchBar {
    
    // Loop through all elements and return textfield
    private func getViewElement<T>(type: T.Type) -> T? {
        let subs = subviews.flatMap { $0.subviews }
        guard let element = (subs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    // Get textfield element within search bar
    func getSearchBarTextField() -> UITextField? {
        return getViewElement(type: UITextField.self)
    }
    
    func setTextColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            textField.textColor = color
        }
    }
    
    // Set textfield text color
    func setTextFieldColor(color: UIColor) {
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
            case .prominent, .default:
                textField.backgroundColor = color
            }
        }
    }
    
    // Set placeholder text color
    func setPlaceholderTextColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: color])
        }
    }
    
    // Set clear button color
    func setTextFieldClearButtonColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            let button = textField.value(forKey: "clearButton") as! UIButton
            if let image = button.imageView?.image {
                button.setImage(image.tint(color: color), for: .normal)
            }
        }
    }
    
    // Set search icon color
    func setSearchImageColor(color: UIColor) {
        if let imageView = getSearchBarTextField()?.leftView as? UIImageView {
            imageView.image = imageView.image?.tint(color: color)
        }
    }
}

// Tint images
extension UIImage {
    func tint(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        color.setFill()
        context.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

