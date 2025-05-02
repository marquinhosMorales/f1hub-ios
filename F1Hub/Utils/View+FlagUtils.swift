//
//  View+FlagUtils.swift
//  F1Hub
//
//  Created by Marcos Morales on 16/04/2025.
//

import SwiftUI
import FlagAndCountryCode

extension View {
    func flagImage(for nationality: String, style: FlagType = .roundedRect) -> some View {
        let countryAliases: [String: String] = [
            "great britain": "United Kingdom",
            "british": "United Kingdom",
            "uk": "United Kingdom",
            "new zealander": "New Zealand",
            "kiwi": "New Zealand",
            "italian": "Italy",
            "usa": "United States",
            "american": "United States",
            "french": "France",
            "german": "Germany",
            "spanish": "Spain",
            "dutch": "Netherlands"
        ]
        
        let country = countryAliases[nationality.lowercased()] ?? nationality
        let countryInfo = CountryFlagInfo.all.first { $0.name.lowercased() == country.lowercased() }
        
        if let countryInfo = countryInfo {
            return AnyView(countryInfo.getCountryImage(with: style))
        } else {
            return AnyView(EmptyView())
        }
    }
}
