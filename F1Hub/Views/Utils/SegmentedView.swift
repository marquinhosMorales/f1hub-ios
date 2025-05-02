//
//  SegmentedView.swift
//  F1Hub
//
//  Created by Marcos Morales on 28/04/2025.
//

import SwiftUI

struct SegmentedView: View {
    let segments: [String]
    let backgroundColor: Color
    let activeColor: Color
    let inactiveColor: Color
    let font: Font
    let animation: Animation
    
    @Namespace private var namespace
    @Binding var selected: Int
    
    init(
        segments: [String],
        selected: Binding<Int>,
        initialSelection: String? = nil,
        backgroundColor: Color = .background,
        activeColor: Color = .accent,
        inactiveColor: Color = .lightGray,
        font: Font = .custom("Formula1-Display-Regular", size: 14),
        animation: Animation = .spring(response: 0.3, dampingFraction: 0.7)
    ) {
        self.segments = segments
        
        self.backgroundColor = backgroundColor
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.font = font
        self.animation = animation
        self._selected = selected
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Segments
            HStack(spacing: 0) {
                ForEach(segments.indices, id: \.self) { index in
                    Button(action: {
                        selected = index
                    }) {
                        Text(segments[index])
                            .font(font)
                            .fontWeight(selected == index ? .medium : .regular)
                            .foregroundColor(selected == index ? activeColor : inactiveColor)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .background(backgroundColor)
            
            // Indicator
            GeometryReader { geo in
                let segmentWidth = geo.size.width / CGFloat(segments.count)
                Rectangle()
                    .fill(activeColor)
                    .frame(width: segmentWidth, height: 4)
                    .offset(x: CGFloat(selected) * segmentWidth)
                    .matchedGeometryEffect(id: "Tab", in: namespace)
                    .animation(animation, value: selected)
            }
            .frame(height: 4)
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview("Light Mode") {
    @Previewable @State var selected: Int = 0
    
    return SegmentedView(
        segments: ["Drivers", "Teams"],
        selected: $selected
    )
}
