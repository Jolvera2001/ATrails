//
//  ATrailsApp.swift
//  ATrails
//
//  Created by Turing on 11/10/23.
//

import SwiftUI
import Firebase

@main
struct ATrailsApp: App {
    @StateObject var authController = AuthController()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            IntroView().environmentObject(authController)
        }
    }
}
