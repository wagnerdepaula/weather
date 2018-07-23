//
//  HistoryCell.swift
//  weather
//
//  Created by Wagner De Paula on 7/21/18.
//

import UIKit

class HistoryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var woeidTitleLabel: UILabel!
    @IBOutlet weak var woeidLabel: UILabel!
    @IBOutlet weak var coordinatesTitleLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    var initialized = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard initialized == false else { return }
        initialized = true
        
        // Set cell styles
        titleLabel.font = Font.medium.of(size: 18)
        titleLabel.textColor = Color.blue
        
        woeidTitleLabel.font = Font.medium.of(size: 12)
        woeidTitleLabel.textColor = Color.gray
        woeidTitleLabel.text = "WOEID"
        woeidLabel.font = Font.regular.of(size: 12)
        woeidLabel.textColor = Color.gray
        
        coordinatesTitleLabel.font = Font.medium.of(size: 12)
        coordinatesTitleLabel.textColor = Color.gray
        coordinatesTitleLabel.text = "COORDINATES"
        coordinatesLabel.font = Font.regular.of(size: 12)
        coordinatesLabel.textColor = Color.gray
    }
}
