//
//  UIImageView.swift
//  weather
//
//  Created by Wagner De Paula on 7/22/18.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: String) {
        let path = URL(string: url)
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: path!)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    self.fadeIn()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        self.alpha = 0
    }
    
    func fadeIn() {
        UIView.animate(withDuration: 0.8, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 3, options: [.allowUserInteraction], animations: { () -> Void in
            self.alpha = 1
        })
    }
}
