//
//  TeamDetailHeader.swift
//  F1Hub
//
//  Created by Marcos Morales on 13/10/2025.
//

import Kingfisher
import SwiftUI

struct TeamDetailHeader: View {
    let name: String?
    let color: Color?
    let imageUrl: WikipediaImage?

    @State private var downloadFailed = false

    private var fallbackImage: some View {
        Image(systemName: "car.circle")
            .resizable()
            .scaledToFit()
            .frame(height: 250)
            .foregroundColor(.secondary)
    }

    var body: some View {
        VStack(spacing: 16) {
            Group {
                if let imageURL = URL(string: imageUrl?.source ?? "") {
                    KFImage(imageURL)
                        .placeholder { ProgressView() }
                        .cacheOriginalImage()
                        .onFailure { error in
                            print("Job failed: \(error.localizedDescription)")
                            downloadFailed = true
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150, alignment: .center)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 24)
                } else if downloadFailed || isRunningInPreview() {
                    fallbackImage
                }
            }
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 4)

            if let name {
                Text(name)
                    .boldTextStyle(22)
            }
        }
    }
}

#Preview("Light Mode") {
    TeamDetailHeader(name: Team.mockRedBull.teamName,
                     color: Team.mockRedBull.teamId?.color(),
                     imageUrl: nil)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    TeamDetailHeader(name: Team.mockRedBull.teamName,
                     color: Team.mockRedBull.teamId?.color(),
                     imageUrl: nil)
        .preferredColorScheme(.dark)
}
