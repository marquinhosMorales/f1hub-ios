//
//  Line.swift
//  F1Hub
//
//  Created by Marcos Morales on 28/04/2025.
//

import SwiftUI

enum LineOrientation {
    case vertical
    case horizontal
}

struct Line: Shape {
    let orientation: LineOrientation
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        switch orientation {
        case .vertical:
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        case .horizontal:
            path.move(to: CGPoint(x: 0, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        }
        return path
    }
}
