//
//  LoginViewModel.swift
//  MovieTask
//
//  Created by Gaurav R on 12/07/23.
//

import Foundation

class LoginViewModel {
    
    func validateEmailAndPassword(emailAddress: String?, password: String?) -> Bool {
        guard let email = emailAddress else { return false }
        guard let pass = password else { return false }
        
        var isValidEmail: Bool = false
        var isValidPassword: Bool = false
        
        if email.isValidEmail() == true {
            isValidEmail = true
        }
        
        if pass.count > 7 && pass.count < 16 {
            isValidPassword = true
        }
        
        return isValidEmail && isValidPassword
    }
}

