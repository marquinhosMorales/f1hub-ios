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
            .toolbarBackground(Color.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

extension View {
    func navigationBarStyle() -> some View {
        modifier(NavigationBarStyle())
    }
}
