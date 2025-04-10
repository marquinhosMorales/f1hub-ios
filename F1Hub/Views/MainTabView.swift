//
//  ContentView.swift
//  F1Hub
//
//  Created by Marcos Morales on 09/04/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DriverListView()
                .tabItem {
                    Label("Drivers", systemImage: "steeringwheel")
                }
        }
    }
}

#Preview("Light Mode") {
    MainTabView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    MainTabView()
        .preferredColorScheme(.dark)
}
