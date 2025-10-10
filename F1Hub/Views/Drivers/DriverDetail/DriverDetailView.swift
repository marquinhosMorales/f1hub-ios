//
//  DriverDetail.swift
//  F1Hub
//
//  Created by Marcos Morales on 01/10/2025.
//

import SwiftUI

struct DriverDetailView: View {
    @StateObject private var viewModel: DriverDetailViewModel

    init(driverId: String, url: String) {
        _viewModel = StateObject(wrappedValue: DriverDetailViewModel(driverId: driverId, wikiUrl: url))
    }

    init(viewModel: DriverDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 10) {
                    // Hero section with image, name, and basic info
                    DriverDetailHeader(number: viewModel.driver?.number,
                                       name: viewModel.driver?.driverName,
                                       imageUrl: viewModel.summary?.originalimage ?? viewModel.summary?.thumbnail)

                    DriverDetailBody(driver: viewModel.driver,
                                     biography: viewModel.summary?.extract)
                }
                .padding()
            }
            .refreshable {
                await viewModel.fetchDriverDetails()
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
                await viewModel.fetchDriverDetails()
            }
        }
    }
}

#Preview("Light Mode") {
    let mockVerstappen = Driver.mockVerstappen
    let viewModel = DriverDetailViewModel(driverId: mockVerstappen.id, wikiUrl: mockVerstappen.url)
    viewModel.driver = mockVerstappen
    viewModel.summary = Driver.mockVerstappenWikipedia
    viewModel.state = .finished
    return DriverDetailView(viewModel: viewModel).preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let mockVerstappen = Driver.mockVerstappen
    let viewModel = DriverDetailViewModel(driverId: mockVerstappen.id, wikiUrl: mockVerstappen.url)
    viewModel.driver = mockVerstappen
    viewModel.summary = Driver.mockVerstappenWikipedia
    viewModel.state = .finished
    return DriverDetailView(viewModel: viewModel).preferredColorScheme(.dark)
}

#Preview("Error") {
    let mockVerstappen = Driver.mockVerstappen
    let viewModel = DriverDetailViewModel(driverId: mockVerstappen.id, wikiUrl: mockVerstappen.url)
    viewModel.state = .error(APIError.networkError(NSError(domain: "", code: -1)))
    return DriverDetailView(viewModel: viewModel)
}
