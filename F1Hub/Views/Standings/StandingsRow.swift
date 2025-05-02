//
//  StandingsRow.swift
//  F1Hub
//
//  Created by Marcos Morales on 02/05/2025.
//

import SwiftUI

struct StandingsRow: View {
    let standingsEntry: StandingsEntry
    
    private var isLeader: Bool {
        standingsEntry.position == 1
    }
    
    private var entryInfo: some View {
        VStack(alignment: .leading) {
            if let driver = standingsEntry.driver {
                Text("\(driver.name) \(driver.surname)")
                    .foregroundColor(isLeader ? .white : .primary)
                    .boldTextStyle(16)
                Text(standingsEntry.teamId.name())
                    .foregroundColor(isLeader ? .white : .secondary)
                    .regularTextStyle(16)
            } else {
                Text(standingsEntry.teamId.name())
                    .foregroundColor(isLeader ? .white : .primary)
                    .boldTextStyle(16)
            }

        }
    }
    
    var body: some View {
        HStack {
            Text(String(standingsEntry.position))
                .foregroundColor(isLeader ? .white : .primary)
                .boldTextStyle(16)
                .monospacedDigit()
                .frame(width: 30, alignment: .center)
            
            Rectangle()
                .fill(standingsEntry.teamId.color())
                .frame(width: 4)
                .frame(maxHeight: 80)
                .padding(.horizontal, 8)
            
            entryInfo
                .frame(minHeight: 50)
            
            Spacer()
            
            Text("\(standingsEntry.points) PTS")
                .foregroundColor(isLeader ? .white : .primary)
                .boldTextStyle(12)

        }
        .background(isLeader ? .standingsLeaderBackground : .clear)
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
