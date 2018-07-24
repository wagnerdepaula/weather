//
//  UITableViewCell.swift
//  weather
//
//  Created by Wagner De Paula on 7/22/18.
//

import UIKit

extension UITableViewCell {
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        // Selected View
        let selected = UIView()
        selected.backgroundColor = Color.highlight
        selectedBackgroundView = selected
        backgroundColor = Color.white
        alpha = 1.0
        separatorInset = .zero
    }
}

extension UITableView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        separatorColor = Color.separator
        isOpaque = true
    }
    
    func showSpinner() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.startAnimating()
        backgroundView = spinner
    }
    
    func hideSpinner() {
        backgroundView = UIView()
    }
}
