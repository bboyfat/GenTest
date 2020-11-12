//
//  UIViewController + Error.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import UIKit

extension UIViewController {
    func showError(_ title: String?) {
        let ac = UIAlertController(title: "ERROR", message: title, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive)
        ac.addAction(ok)
        self.present(ac, animated: true)
    }
}
