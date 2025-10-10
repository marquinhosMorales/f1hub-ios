//
//  DriverDetailHeader.swift
//  F1Hub
//
//  Created by Marcos Morales on 09/10/2025.
//

import Kingfisher
import SwiftUI

struct DriverDetailHeader: View {
    let number: Int?
    let name: String?
    let imageUrl: WikipediaImage?

    @State private var downloadFailed = false

    private var fallbackImage: some View {
        Image(systemName: "person.circle")
            .resizable()
            .scaledToFit()
            .frame(height: 250)
            .foregroundColor(.secondary)
    }

    var body: some View {
        VStack(spacing: 12) {
            if let imageURL = URL(string: imageUrl?.source ?? "") {
                KFImage(imageURL)
                    .placeholder { ProgressView() }
                    .cacheOriginalImage()
                    .onFailure { error in
                        print("Job failed: \(error.localizedDescription)")
                        downloadFailed = true
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(height: 350, alignment: .top)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)
            } else if downloadFailed || isRunningInPreview() {
                fallbackImage
            }

            HStack(alignment: .center, spacing: 14) {
                if let number {
                    Text(String(format: "%02d", number))
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.accent)
                        .monospacedDigit()
                }
                if let name {
                    Text(name)
                        .boldTextStyle(22)
                }
            }
        }
    }
}

#Preview("Light Mode") {
    DriverDetailHeader(number: Driver.mockVerstappen.number,
                       name: Driver.mockVerstappen.driverName,
                       imageUrl: nil)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    DriverDetailHeader(number: Driver.mockVerstappen.number,
                       name: Driver.mockVerstappen.driverName,
                       imageUrl: nil)
        .preferredColorScheme(.dark)
}
