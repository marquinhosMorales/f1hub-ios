//
//  StandingsView.swift
//  F1Hub
//
//  Created by Marcos Morales on 30/04/2025.
//

import SwiftUI

struct StandingsView: View {
    @StateObject private var viewModel = StandingsViewModel()

    @State private var selectedSegment = 0

    init(viewModel: StandingsViewModel = StandingsViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    SegmentedView(
                        segments: ["Drivers", "Teams"],
                        selected: $selectedSegment,
                        backgroundColor: .accent,
                        activeColor: .white,
                        inactiveColor: .white.opacity(0.6)
                    )

                    List {
                        ForEach(selectedSegment == 0 ? viewModel.driversStandings : viewModel.teamsStandings) { standingsEntry in
                            Group {
                                if selectedSegment == 0,
                                   let driverId = standingsEntry.driverId,
                                   let driverUrl = standingsEntry.driver?.url {
                                    NavigationLink(
                                        destination: DriverDetailView(driverId: driverId, url: driverUrl)
                                    ) {
                                        StandingsRow(standingsEntry: standingsEntry)
                                    }
                                    .rowStyle()
                                    .rowBorder(color: standingsEntry.isLeader ? .gold : .clear)
                                } else {
                                    NavigationLink(
                                        destination: TeamDetailView(teamId: standingsEntry.teamId.rawValue,
                                                                    url: standingsEntry.team.url)
                                    ) {
                                        StandingsRow(standingsEntry: standingsEntry)
                                    }
                                    .rowStyle()
                                    .rowBorder(color: standingsEntry.isLeader ? .gold : .clear)
                                }
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
            }
            .task {
                if !isRunningInPreview() {
                    await viewModel.fetchCurrentDriversStandings()
                    await viewModel.fetchCurrentTeamsStandings()
                }
            }
        }
    }
}

#Preview("Light Mode") {
    let viewModel = StandingsViewModel()
    viewModel.driversStandings = StandingsEntry.mockDriversStandings()
    viewModel.teamsStandings = StandingsEntry.mockTeamsStandings()
    viewModel.state = .finished
    return StandingsView(viewModel: viewModel).preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let viewModel = StandingsViewModel()
    viewModel.driversStandings = StandingsEntry.mockDriversStandings()
    viewModel.teamsStandings = StandingsEntry.mockTeamsStandings()
    viewModel.state = .finished
    return StandingsView(viewModel: viewModel).preferredColorScheme(.dark)
}

#Preview("Error") {
    let viewModel = StandingsViewModel()
    viewModel.state = .error(APIError.networkError(NSError(domain: "", code: -1)))
    return StandingsView(viewModel: viewModel)
}
