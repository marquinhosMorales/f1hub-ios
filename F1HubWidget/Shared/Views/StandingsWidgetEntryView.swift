//
//  StandingsWidgetEntryView.swift
//  F1Hub
//
//  Created by Marcos Morales on 21/10/2025.
//

import SwiftUI
import WidgetKit

struct StandingsWidgetEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: StandingsProvider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            StandingsSmallView(entry: entry)
        case .systemMedium:
            StandingsMediumView(entry: entry)
        default:
            EmptyView()
        }
    }
}
