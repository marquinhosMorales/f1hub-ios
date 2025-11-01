//
//  StandingsViewModelTests.swift
//  F1Hub
//
//  Created by Marcos Morales on 29/10/2025.
//

import Combine
@testable import F1Hub
import XCTest

final class StandingsViewModelTests: XCTestCase {
    private var viewModel: StandingsViewModel!
    private var mockF1Service: MockF1APIService!

    override func setUp() {
        super.setUp()
        mockF1Service = MockF1APIService()
        viewModel = StandingsViewModel(f1APIService: mockF1Service)
    }

    override func tearDown() {
        viewModel = nil
        mockF1Service = nil
        super.tearDown()
    }

    func testFetchCurrentDriversStandings_Success() async {
        // Given
        let expectedStandings = StandingsEntry.mockDriversStandings()

        mockF1Service.fetchCurrentDriversStandingsHandler = { () async throws -> [StandingsEntry] in
            expectedStandings
        }

        // When
        await viewModel.fetchCurrentDriversStandings()

        // Then
        XCTAssertEqual(viewModel.driversStandings, expectedStandings)
        XCTAssertEqual(viewModel.state, .finished)
        XCTAssertEqual(viewModel.teamsStandings, [])
    }

    func testFetchCurrentTeamsStandings_Success() async {
        // Given
        let expectedStandings = StandingsEntry.mockTeamsStandings()

        mockF1Service.fetchCurrentTeamsStandingsHandler = { () async throws -> [StandingsEntry] in
            expectedStandings
        }

        // When
        await viewModel.fetchCurrentTeamsStandings()

        // Then
        XCTAssertEqual(viewModel.teamsStandings, expectedStandings)
        XCTAssertEqual(viewModel.state, .finished)
        XCTAssertEqual(viewModel.driversStandings, [])
    }

    func testIsLeaderProperty() {
        // Given
        let leader = StandingsEntry.mockVerstappenEntry
        let nonLeader = StandingsEntry.mockNorrisEntry

        // Then
        XCTAssertTrue(leader.isLeader)
        XCTAssertFalse(nonLeader.isLeader)
    }

    func testFetchDriversStandings_Error() async {
        // Given
        let expectedError = F1APIError.driverNotFound

        mockF1Service.fetchCurrentDriversStandingsHandler = { () async throws -> [StandingsEntry] in
            throw expectedError
        }

        // When
        await viewModel.fetchCurrentDriversStandings()

        // Then
        XCTAssertTrue(viewModel.driversStandings.isEmpty)
        if case let .error(error) = viewModel.state {
            XCTAssertEqual(error as? F1APIError, expectedError)
        } else {
            XCTFail("Expected error state")
        }
    }
}
