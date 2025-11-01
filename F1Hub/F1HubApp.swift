//
//  MainView.swift
//  F1Hub
//
//  Created by Marcos Morales on 09/04/2025.
//

import SwiftUI

@main
struct F1HubApp: App {
    init() {
        // Enable mock API when the UI-test runner passes the argument
        if CommandLine.arguments.contains("-useMockAPI") {
            AppDependencyContainer.shared.useMockServices()
        }
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
