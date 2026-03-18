//
//  AuthManager.swift
//  RickAndMort
//
//  Created by Okan on 18.03.2026.
//

import Foundation
import Observation

@Observable
class AuthManager {
    static let shared = AuthManager()
    var isLoggedIn: Bool = false
    
    private init() {}
    
    func login() {
        isLoggedIn = true
    }
}
