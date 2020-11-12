//
//  UIImageView + load.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import Nuke
import UIKit

extension UIImageView {
    func loadImage(path: String) {
        guard let url = URL(string: path) else {
            return
        }
        Nuke.loadImage(with: url, into: self)
    }
}
