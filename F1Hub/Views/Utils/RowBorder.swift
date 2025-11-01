//
//  RowBorder.swift
//  F1Hub
//
//  Created by Marcos Morales on 31/10/2025.
//

import SwiftUI

struct RowBorderModifier: ViewModifier {
    let color: Color
    let cornerRadius: CGFloat
    let lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(color, lineWidth: lineWidth)
            )
    }
}

extension View {
    func rowBorder(color: Color = Color.clear, cornerRadius: CGFloat = 0, lineWidth: CGFloat = 2) -> some View {
        modifier(RowBorderModifier(color: color, cornerRadius: cornerRadius, lineWidth: lineWidth))
    }
}
