//
//  ListStyle.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import SwiftUI

struct ListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
            .background(Color.background)
    }
}

extension View {
    func listStyle() -> some View {
        modifier(ListStyle())
    }
}
