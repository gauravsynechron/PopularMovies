//
//  String+Extension.swift
//  MovieTask
//
//  Created by Gaurav R on 12/07/23.
//

import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailFormat = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
