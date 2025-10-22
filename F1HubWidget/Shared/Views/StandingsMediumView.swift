//
//  StandingsMediumView.swift
//  F1Hub
//
//  Created by Marcos Morales on 21/10/2025.
//

import SwiftUI
import WidgetKit

struct StandingsMediumView: View {
    let entry: StandingsProvider.Entry

    private var type: StandingsType? {
        entry.type
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 4) {
                Image(systemName: "trophy.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                Text(type == .drivers ? "Drivers Standings" : "Teams Standings")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.white)
            }

            let topStandings = Array(entry.standings.prefix(3))
            ForEach(topStandings, id: \.id) { standingEntry in
                let name = type == .drivers ? (standingEntry.driver?.driverName ?? "") : standingEntry.team.teamName

                HStack(spacing: 8) {
                    Text("\(standingEntry.position)")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.white)
                        .monospacedDigit()

                    Rectangle()
                        .fill(standingEntry.teamId.color())
                        .frame(width: 4)
                        .frame(maxHeight: 36)
                        .shadow(radius: 1)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(name)
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.white)
                            .lineLimit(1)
                        if type == .drivers {
                            Text(standingEntry.team.teamName)
                                .font(.caption)
                                .bold()
                                .foregroundStyle(.white.opacity(0.7))
                        }
                    }

                    Spacer()

                    Text("\(standingEntry.points) PTS")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.white)
                }
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
