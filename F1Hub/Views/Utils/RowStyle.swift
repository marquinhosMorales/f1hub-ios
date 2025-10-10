//
//  RowStyle.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import SwiftUI

struct RowStyle: ViewModifier {
    let textColor: Color

    func body(content: Content) -> some View {
        content
            .padding(16)
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .listRowInsets(EdgeInsets())
            .alignmentGuide(.listRowSeparatorLeading) { dimensions in
                dimensions[.leading]
            }
            .alignmentGuide(.listRowSeparatorTrailing) { dimensions in
                dimensions[.trailing]
            }
    }
}

extension View {
    func rowStyle(textColor: Color = .textPrimary) -> some View {
        modifier(RowStyle(textColor: textColor))
    }
}
