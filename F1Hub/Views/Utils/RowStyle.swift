//
//  RowStyle.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import SwiftUI

struct RowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .foregroundColor(Color.textPrimary)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color.backgroundColor)
            .listRowInsets(EdgeInsets())
    }
}

extension View {
    func rowStyle(backgroundColor: Color = .backgroundColor, textColor: Color = .textPrimary) -> some View {
        modifier(RowStyle())
    }
}
