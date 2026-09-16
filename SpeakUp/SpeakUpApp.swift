//
//  SpeakUpApp.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//

import SwiftUI
import SwiftData

@main
struct SpeakUpApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
        .modelContainer(for: ConfidenceScore.self)
    }
}

