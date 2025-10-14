//
//  DriverDetailBody.swift
//  F1Hub
//
//  Created by Marcos Morales on 09/10/2025.
//

import SwiftUI

struct DriverDetailBody: View {
    let driver: Driver?
    let biography: String?

    var body: some View {
        if let driver {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    InfoRow(title: "Nationality", value: "\(driver.nationality ?? driver.country ?? "")", isNationality: true)
                    InfoRow(title: "Date of Birth", value: driver.birthday.formattedDate())
                    if let age = driver.age {
                        InfoRow(title: "Age", value: "\(age)")
                    }
                    if let teamId = driver.teamId {
                        InfoRow(title: "Team", value: teamId.name())
                    }
                    InfoRow(title: "Short Name", value: driver.shortName)
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
    DriverDetailBody(driver: Driver.mockVerstappen,
                     biography: Driver.mockVerstappenWikipedia.extract)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    DriverDetailBody(driver: Driver.mockVerstappen,
                     biography: Driver.mockVerstappenWikipedia.extract)
        .preferredColorScheme(.dark)
}
