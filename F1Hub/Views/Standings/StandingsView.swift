//
//  StandingsView.swift
//  F1Hub
//
//  Created by Marcos Morales on 30/04/2025.
//

import SwiftUI

struct StandingsView: View {
    @StateObject private var viewModel = StandingsViewModel()
    
    init(viewModel: StandingsViewModel = StandingsViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
        
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.data) { standingsEntry in
                        HStack {
                            Text("\(standingsEntry.position).")
                            if let driver = standingsEntry.driver {
                                Text("\(driver.name) \(driver.surname)")
                            }
                            Spacer()
                            Text("\(standingsEntry.points)")
                        }
                    }
                }
                .navigationBarStyle(withTitle: "Standings")
                .listStyle()
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
                    await viewModel.fetchCurrentDriversStandings()
                }
            }
        }
    }
}

#Preview("Light Mode") {
    let viewModel = StandingsViewModel()
    viewModel.data = StandingsEntry.mockStandings()
    viewModel.state = .finished
    return StandingsView(viewModel: viewModel).preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let viewModel = StandingsViewModel()
    viewModel.data = StandingsEntry.mockStandings()
    viewModel.state = .finished
    return StandingsView(viewModel: viewModel).preferredColorScheme(.dark)
}

#Preview("Error") {
    let viewModel = StandingsViewModel()
    viewModel.state = .error(APIError.networkError(NSError(domain: "", code: -1)))
    return StandingsView(viewModel: viewModel)
}
