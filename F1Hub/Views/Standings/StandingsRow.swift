//
//  StandingsRow.swift
//  F1Hub
//
//  Created by Marcos Morales on 02/05/2025.
//

import SwiftUI

struct StandingsRow: View {
    let standingsEntry: StandingsEntry

    private var entryInfo: some View {
        VStack(alignment: .leading) {
            if let driver = standingsEntry.driver {
                Text("\(driver.name) \(driver.surname)")
                    .foregroundColor(standingsEntry.isLeader ? .gold : .primary)
                    .boldTextStyle(16)
                Text(standingsEntry.teamId.name())
                    .foregroundColor(standingsEntry.isLeader ? .gold.opacity(0.75) : .secondary)
                    .regularTextStyle(16)
            } else {
                Text(standingsEntry.teamId.name())
                    .foregroundColor(standingsEntry.isLeader ? .gold : .primary)
                    .boldTextStyle(16)
            }
        }
    }

    var body: some View {
        HStack {
            Group {
                if standingsEntry.isLeader {
                    HStack(spacing: 0) {
                        Image(systemName: "laurel.leading")
                            .font(.system(size: 12))
                            .foregroundStyle(.gold)
                        Image(systemName: "1.circle.fill")
                            .font(.system(size: 18)) // Smaller than .title3 to fit
                            .foregroundStyle(.gold)
                        Image(systemName: "laurel.trailing")
                            .font(.system(size: 12))
                            .foregroundStyle(.gold)
                    }
                } else {
                    Text(String(standingsEntry.position))
                        .foregroundColor(.primary)
                        .boldTextStyle(16)
                        .monospacedDigit()
                }
            }
            .frame(width: 40)

            Rectangle()
                .fill(standingsEntry.teamId.color())
                .frame(width: 4)
                .frame(maxHeight: 80)
                .padding(.leading, 4)
                .padding(.trailing, 8)

            entryInfo
                .frame(minHeight: 50)

            Spacer()

            Text("\(standingsEntry.points) PTS")
                .foregroundColor(standingsEntry.isLeader ? .gold : .primary)
                .boldTextStyle(12)
        }
    }
}

#Preview("Light Mode") {
    StandingsRow(standingsEntry: StandingsEntry.mockVerstappenEntry)
        .preferredColorScheme(.light)
    StandingsRow(standingsEntry: StandingsEntry.mockNorrisEntry)
        .preferredColorScheme(.light)
    StandingsRow(standingsEntry: StandingsEntry.mockRedBullEntry)
        .preferredColorScheme(.light)
    StandingsRow(standingsEntry: StandingsEntry.mockMcLarenEntry)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    StandingsRow(standingsEntry: StandingsEntry.mockVerstappenEntry)
        .preferredColorScheme(.dark)
    StandingsRow(standingsEntry: StandingsEntry.mockNorrisEntry)
        .preferredColorScheme(.dark)
    StandingsRow(standingsEntry: StandingsEntry.mockRedBullEntry)
        .preferredColorScheme(.dark)
    StandingsRow(standingsEntry: StandingsEntry.mockMcLarenEntry)
        .preferredColorScheme(.dark)
}
