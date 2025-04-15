//
//  NavigationBarStyle.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import SwiftUICore

struct NavigationBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.backgroundColor, for: .navigationBar)
            .toolbarBackground(Color.backgroundColor, for: .tabBar)
    }
}

extension View {
    func navigationBarStyle() -> some View {
        modifier(NavigationBarStyle())
    }
}
