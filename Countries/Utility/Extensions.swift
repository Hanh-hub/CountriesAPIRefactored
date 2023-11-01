//
//  Extensions.swift
//  Countries
//
//  Created by Hanh Vo on 9/26/23.
//

import Foundation
import UIKit

extension ViewController {
    func presentErrorMessage(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
