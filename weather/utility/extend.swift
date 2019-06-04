//
//  extend.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct Custom {
        static let yellow = UIColor(red: 250/255, green: 185/255, blue:  21/255, alpha: 1)
        static let dark   = UIColor(red:  25/255, green:  25/255, blue:  25/255, alpha: 1)
        static let light  = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        static let gray   = UIColor(red: 139/255, green: 139/255, blue: 139/255, alpha: 1)
    }
}

// Load External Resources
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
