//
//  RaceRow.swift
//  F1Hub
//
//  Created by Marcos Morales on 28/04/2025.
//

import SwiftUI

struct RaceRow: View {
    let race: Race
    
    var body: some View {
        let roundNumber = String(format: "%02d", race.round)
        
        HStack {
            VStack(alignment: .center) {
                Text(race.days())
                    .regularTextStyle(14)
                Text(race.months().uppercased())
                    .boldTextStyle(14)
            }
            .frame(width: 60, alignment: .leading)
            
            Line(orientation: .vertical)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
                .foregroundColor(.secondary)
                .frame(width: 2)
                .frame(maxHeight: 80)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text("Round \(roundNumber)".uppercased())
                    .foregroundColor(Color.accent)
                    .boldTextStyle(14)
                Text(race.circuit.city)
                    .boldTextStyle(18)
                Text(race.raceName.uppercased())
                    .foregroundColor(Color.secondary)
                    .regularTextStyle(14)
            }
        }
        
    }
}

#Preview("Light Mode") {
    RaceRow(race: Race.mockSpain)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    RaceRow(race: Race.mockSpain)
        .preferredColorScheme(.dark)
}
