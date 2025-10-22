//
//  F1HubWidgetBundle.swift
//  F1HubWidget
//
//  Created by Marcos Morales on 16/10/2025.
//

import SwiftUI
import WidgetKit

@main
struct F1HubWidgetBundle: WidgetBundle {
    var body: some Widget {
        DriversStandingsWidget()
        TeamsStandingsWidget()
    }
}
