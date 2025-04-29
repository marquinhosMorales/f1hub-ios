//
//  RaceListView.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/04/2025.
//

import SwiftUI

struct RaceListView: View {
    @StateObject private var viewModel = RaceListViewModel()
    
    @State private var selectedSegment = 0
    
    init(viewModel: RaceListViewModel = RaceListViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
        
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SegmentedView(
                        segments: ["Upcoming", "Past"],
                        selected: $selectedSegment,
                        backgroundColor: .accent,
                        activeColor: .white,
                        inactiveColor: .white.opacity(0.6)
                    )
                                
                    List {
                        ForEach(selectedSegment == 0 ? viewModel.upcomingRaces : viewModel.pastRaces) { race in
                            RaceRow(race: race)
                                .rowStyle()
                        }
                    }
                    .navigationBarStyle(withTitle: "Races")
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
                    await viewModel.fetchCurrentraces()
                }
            }
        }
    }
}

#Preview("Light Mode") {
    let viewModel = RaceListViewModel()
    viewModel.data = Race.mockRaces()
    viewModel.state = .finished
    return RaceListView(viewModel: viewModel).preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let viewModel = RaceListViewModel()
    viewModel.data = Race.mockRaces()
    viewModel.state = .finished
    return RaceListView(viewModel: viewModel).preferredColorScheme(.dark)
}

#Preview("Error") {
    let viewModel = RaceListViewModel()
    viewModel.state = .error(APIError.networkError(NSError(domain: "", code: -1)))
    return RaceListView(viewModel: viewModel)
}
