//
//  TeamDetailBody.swift
//  F1Hub
//
//  Created by Marcos Morales on 13/10/2025.
//

import SwiftUI

struct TeamDetailBody: View {
    let team: Team?
    let biography: String?

    var body: some View {
        if let team {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    InfoRow(title: "Team Nationality", value: "\(team.teamNationality ?? team.country ?? "")", isNationality: true)
                    if let firstAppearance = team.firstAppearance {
                        InfoRow(title: "First Appeareance", value: "\(firstAppearance)")
                    }
                    InfoRow(title: "Constructors Championships", value: "\(team.constructorsChampionships ?? 0)")
                    InfoRow(title: "Drivers Championships", value: "\(team.driversChampionships ?? 0)")
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 2)
            } header: {
                Text("Information")
                    .font(.headline)
            }
        }
        if let biography {
            Section {
                Text(biography)
                    .font(.body)
                    .lineSpacing(4)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 2)
            } header: {
                Text("Biography")
                    .font(.headline)
            }
        }
    }
}

#Preview("Light Mode") {
    TeamDetailBody(team: Team.mockRedBull,
                   biography: Team.mockRedBullWikipedia.extract)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    TeamDetailBody(team: Team.mockRedBull,
                   biography: Team.mockRedBullWikipedia.extract)
        .preferredColorScheme(.dark)
}
