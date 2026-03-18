//
//  LoginViewModel.swift
//  RickAndMort
//
//  Created by Okan on 18.03.2026.
//

import Foundation
import Observation

@Observable
class LoginViewModel {
    var username = ""
    var password = ""
    
    func performLogin() {
        if !username.isEmpty && !password.isEmpty {
            AuthManager.shared.login()
        }
    }
}
