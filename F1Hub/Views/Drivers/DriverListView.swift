//
//  DriverListView.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import SwiftUI

struct DriverListView: View {
    @StateObject private var viewModel = DriverListViewModel()
    
    init(viewModel: DriverListViewModel = DriverListViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
        
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.data) { driver in
                        HStack {
                            Text(String(format: "%02d", driver.number))
                                .foregroundColor(Color.accentColor)
                                .wideTextStyle(12)
                                .monospacedDigit()
                            Text("\(driver.name) \(driver.surname)")
                                .boldTextStyle(16)
                            flagImage(for: driver.nationality)
                        }
                        .rowStyle()
                    }
                }
                .navigationBarStyle()
                .listStyle()
                .navigationTitle("Drivers")
                .alert(isPresented: viewModel.isPresentingError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                if viewModel.state == .loading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            .task {
                if !isRunningInPreview() {
                    await viewModel.fetchCurrentDrivers()
                }
            }
        }
    }
}

#Preview("Light Mode") {
    let viewModel = DriverListViewModel()
    viewModel.data = Driver.mockDrivers()
    viewModel.state = .finished
    return DriverListView(viewModel: viewModel).preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let viewModel = DriverListViewModel()
    viewModel.data = Driver.mockDrivers()
    viewModel.state = .finished
    return DriverListView(viewModel: viewModel).preferredColorScheme(.dark)
}

#Preview("Error") {
    let viewModel = DriverListViewModel()
    viewModel.state = .error(APIError.networkError(NSError(domain: "", code: -1)))
    return DriverListView(viewModel: viewModel)
}
