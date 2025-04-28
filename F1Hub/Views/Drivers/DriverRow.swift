//
//  DriverRow.swift
//  F1Hub
//
//  Created by Marcos Morales on 28/04/2025.
//

import SwiftUI

struct DriverRow: View {
    let driver: Driver
    
    var body: some View {
        let teamID = driver.teamId ?? .unknown
        
        HStack {
            Text(String(format: "%02d", driver.number))
                .foregroundColor(Color.primary)
                .wideTextStyle(12)
                .monospacedDigit()
            
            Rectangle()
                .fill(teamID.color())
                .frame(width: 4)
                .frame(maxHeight: 80)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(driver.name) \(driver.surname)")
                        .boldTextStyle(16)
                    if let nationality = driver.nationality {
                        flagImage(for: nationality)
                    }
                }
                Text(teamID.name())
                    .foregroundColor(Color.secondary)
                    .regularTextStyle(16)
            }

        }
    }
}

#Preview("Light Mode") {
    DriverRow(driver: Driver.mockVerstappen)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    DriverRow(driver: Driver.mockVerstappen)
        .preferredColorScheme(.dark)
}
