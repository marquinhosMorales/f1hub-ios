//
//  InfoRow.swift
//  F1Hub
//
//  Created by Marcos Morales on 13/10/2025.
//

import SwiftUI

struct InfoRow: View {
    let title: String
    let value: String
    let isNationality: Bool

    init(title: String, value: String, isNationality: Bool = false) {
        self.title = title
        self.value = value
        self.isNationality = isNationality
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
            if isNationality {
                flagImage(for: value)
            }
        }
    }
}
