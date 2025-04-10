//
//  DriverListView.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import SwiftUI

struct DriverListView: View {
    @StateObject private var viewModel = DriverListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.data) { driver in
                    HStack {
                        Text(String(format: "%02d", driver.number))
                            .foregroundColor(Color.accentColor)
                        Text("\(driver.name) \(driver.surname)")
                    }
                    .rowStyle()
                }
            }
            .onAppear() {
                viewModel.fetchDrivers()
            }
            .navigationTitle("Drivers")
            .navigationBarStyle()
            .listStyle()
        }
    }
}

#Preview("Light Mode") {
    DriverListView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    DriverListView()
        .preferredColorScheme(.dark)
}
