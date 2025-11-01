//
//  StandingsSmallView.swift
//  F1Hub
//
//  Created by Marcos Morales on 21/10/2025.
//

import SwiftUI
import WidgetKit

struct StandingsSmallView: View {
    let entry: StandingsProvider.Entry

    private var type: StandingsType? {
        entry.type
    }

    private var leader: StandingsEntry? {
        entry.standings.first
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack(spacing: 0) {
                    Image(systemName: "laurel.leading")
                        .font(.system(size: 14))
                        .foregroundStyle(.gold)
                    Image(systemName: "1.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.gold)
                    Image(systemName: "laurel.trailing")
                        .font(.system(size: 14))
                        .foregroundStyle(.gold)
                }
                Text("\(type == .drivers ? "Drivers" : "Teams") Leader")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.white)
            }

            if let leader {
                let name = type == .drivers ? (leader.driver?.driverName ?? "") : leader.team.teamName

                VStack(alignment: .leading) {
                    Text(name)
                        .font(.subheadline)
                        .bold()
                    if type == .drivers {
                        Text(leader.team.teamName)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .foregroundStyle(.white)

                Text("\(leader.points) PTS")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.white)
            } else {
                Text("No data")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.white)
            }
        }
        .containerBackground(for: .widget) {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.accent,
                    Color.black.opacity(0.5),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
