//
//  NavigationBarStyle.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import SwiftUI

struct NavigationBarStyle: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.accent, for: .navigationBar)
            .toolbarBackground(Color.background, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .boldTextStyle(18)
                        .foregroundColor(Color.white)
                }
            }
    }
}

extension View {
    func navigationBarStyle(withTitle title: String) -> some View {
        modifier(NavigationBarStyle(title: title))
    }
}
