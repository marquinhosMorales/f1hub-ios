//
//  RaceListView.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/04/2025.
//

import SwiftUI

struct RaceListView: View {
    @StateObject private var viewModel = RaceListViewModel()
    
    init(viewModel: RaceListViewModel = RaceListViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
        
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.data) { race in
                        HStack {
                            Text(race.raceName)
                                .boldTextStyle(16)
                        }
                        .rowStyle()
                    }
                }
                .navigationBarStyle()
                .listStyle()
                .navigationTitle("Races")
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
