//
//  TeamDetailViewModelTests.swift
//  F1Hub
//
//  Created by Marcos Morales on 29/10/2025.
//

import Combine
@testable import F1Hub
import XCTest

final class TeamDetailViewModelTests: XCTestCase {
    private var viewModel: TeamDetailViewModel!
    private var mockF1Service: MockF1APIService!
    private var mockWikipediaAPIService: MockWikipediaAPIService!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockF1Service = MockF1APIService()
        mockWikipediaAPIService = MockWikipediaAPIService()
        viewModel = TeamDetailViewModel(
            teamId: Team.mockRedBull.id,
            wikiUrl: Team.mockRedBull.url,
            f1APIService: mockF1Service,
            wikipediaAPIService: mockWikipediaAPIService
        )
    }

    override func tearDown() {
        viewModel = nil
        mockF1Service = nil
        mockWikipediaAPIService = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchTeamDetails_Success() async {
        // Given
        let expectedTeam = Team.mockRedBull
        let expectedSummary = Team.mockRedBullWikipedia

        mockF1Service.fetchTeamDetailHandler = { _ in
            expectedTeam
        }
        mockWikipediaAPIService.fetchSummaryHandler = { _ in
            expectedSummary
        }

        // When
        await viewModel.fetchTeamDetails()

        // Then
        XCTAssertEqual(viewModel.team, expectedTeam)
        XCTAssertEqual(viewModel.summary, expectedSummary)
        XCTAssertEqual(viewModel.state, .finished)
    }

    func testFetchTeamDetails_F1ServiceError() async {
        // Given
        let expectedError = F1APIError.teamNotFound
        let expectedSummary = Team.mockRedBullWikipedia

        mockF1Service.fetchTeamDetailHandler = { _ in
            throw expectedError
        }
        mockWikipediaAPIService.fetchSummaryHandler = { _ in
            expectedSummary
        }

        // When
        await viewModel.fetchTeamDetails()

        // Then
        // if one async task fails, the other is cancelled
        XCTAssertNil(viewModel.team)
        XCTAssertNil(viewModel.summary)
        if case let .error(error) = viewModel.state {
            XCTAssertEqual(error as? F1APIError, expectedError)
        } else {
            XCTFail("Expected error state")
        }
    }

    func testFetchTeamDetails_WikipediaError() async {
        // Given
        let expectedTeam = Team.mockRedBull
        let expectedError = APIError.invalidURL

        mockF1Service.fetchTeamDetailHandler = { _ in
            expectedTeam
        }
        mockWikipediaAPIService.fetchSummaryHandler = { _ in
            throw expectedError
        }

        // When
        await viewModel.fetchTeamDetails()

        // Then
        // if one async task fails, the other is cancelled
        XCTAssertNil(viewModel.team)
        XCTAssertNil(viewModel.summary)
        if case let .error(error) = viewModel.state {
            XCTAssertEqual(error as? APIError, expectedError)
        } else {
            XCTFail("Expected error state")
        }
    }
}
