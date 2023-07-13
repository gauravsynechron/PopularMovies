//
//  LoginViewModel.swift
//  MovieTask
//
//  Created by Gaurav R on 12/07/23.
//

import Foundation

class LoginViewModel {
    
    private var minPasswordLength = 7
    private var maxPasswordLength = 16
    
    func validateEmailAndPassword(emailAddress: String?, password: String?) -> Bool {
        guard let email = emailAddress else { return false }
        guard let pass = password else { return false }
        
        var isValidEmail: Bool = false
        var isValidPassword: Bool = false
        
        if email.isValidEmail() == true {
            isValidEmail = true
        }
        
        if pass.count > minPasswordLength && pass.count < maxPasswordLength {
            isValidPassword = true
        }
        
        return isValidEmail && isValidPassword
    }
}

