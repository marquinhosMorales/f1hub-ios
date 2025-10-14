//
//  TeamDetailView.swift
//  F1Hub
//
//  Created by Marcos Morales on 13/10/2025.
//

import SwiftUI

struct TeamDetailView: View {
    @StateObject private var viewModel: TeamDetailViewModel

    init(teamId: String, url: String) {
        _viewModel = StateObject(wrappedValue: TeamDetailViewModel(teamId: teamId, wikiUrl: url))
    }

    init(viewModel: TeamDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 10) {
                    TeamDetailHeader(name: viewModel.team?.teamName,
                                     color: viewModel.team?.teamId?.color(),
                                     imageUrl: viewModel.summary?.originalimage ?? viewModel.summary?.thumbnail)

                    TeamDetailBody(team: viewModel.team,
                                   biography: viewModel.summary?.extract)
                }
                .padding()
            }
            .refreshable {
                await viewModel.fetchTeamDetails()
            }

            if viewModel.state == .loading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if let wikiUrl = URL(string: viewModel.wikiUrl) {
                    Link(destination: wikiUrl) {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .alert(isPresented: viewModel.isPresentingError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .task {
            if !isRunningInPreview() {
                await viewModel.fetchTeamDetails()
            }
        }
    }
}

#Preview("Light Mode") {
    let mockRedBull = Team.mockRedBull
    let viewModel = TeamDetailViewModel(teamId: mockRedBull.id, wikiUrl: mockRedBull.url)
    viewModel.team = mockRedBull
    viewModel.summary = Team.mockRedBullWikipedia
    viewModel.state = .finished
    return TeamDetailView(viewModel: viewModel).preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let mockRedBull = Team.mockRedBull
    let viewModel = TeamDetailViewModel(teamId: mockRedBull.id, wikiUrl: mockRedBull.url)
    viewModel.team = mockRedBull
    viewModel.summary = Team.mockRedBullWikipedia
    viewModel.state = .finished
    return TeamDetailView(viewModel: viewModel).preferredColorScheme(.dark)
}

#Preview("Error") {
    let mockRedBull = Team.mockRedBull
    let viewModel = TeamDetailViewModel(teamId: mockRedBull.id, wikiUrl: mockRedBull.url)
    viewModel.state = .error(APIError.networkError(NSError(domain: "", code: -1)))
    return TeamDetailView(viewModel: viewModel)
}
