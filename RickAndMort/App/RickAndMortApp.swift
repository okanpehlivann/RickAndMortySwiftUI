//
//  RickAndMortApp.swift
//  RickAndMort
//
//  Created by Okan on 17.03.2026.
//

import SwiftUI

@main
struct RickAndMortApp: App {
    @State private var auth = AuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            if auth.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
