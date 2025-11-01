//
//  RaceListViewModelTests.swift
//  F1Hub
//
//  Created by Marcos Morales on 29/10/2025.
//

import Combine
@testable import F1Hub
import XCTest

final class RaceListViewModelTests: XCTestCase {
    private var viewModel: RaceListViewModel!
    private var mockF1Service: MockF1APIService!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockF1Service = MockF1APIService()
        viewModel = RaceListViewModel(f1APIService: mockF1Service)
    }

    override func tearDown() {
        viewModel = nil
        mockF1Service = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchCurrentRaces_Success() async {
        // Given
        let expectedRaces = Race.mockRaces()

        mockF1Service.fetchCurrentRacesHandler = { () async throws -> [Race] in
            expectedRaces
        }

        // When
        await viewModel.fetchCurrentRaces()

        // Then
        XCTAssertEqual(viewModel.data, expectedRaces)
        XCTAssertEqual(viewModel.state, .finished)
    }

    func testUpcomingRaces_WhenFutureDates() async {
        // Given: Mock races with future dates
        let futureRaces = [Race.mockSpain]
        mockF1Service.fetchCurrentRacesHandler = { () async throws -> [Race] in
            futureRaces
        }
        await viewModel.fetchCurrentRaces()

        // Then
        XCTAssertEqual(viewModel.upcomingRaces, futureRaces.sorted { $0.round < $1.round })
        XCTAssert(viewModel.pastRaces.isEmpty)
    }

    func testPastRaces_WhenPastDates() async {
        // Given: Mock races with past dates
        let pastRaces = [Race.mockAustralia]
        mockF1Service.fetchCurrentRacesHandler = { () async throws -> [Race] in
            pastRaces
        }
        await viewModel.fetchCurrentRaces()

        // Then
        XCTAssertEqual(viewModel.pastRaces, pastRaces.sorted { $0.round < $1.round })
        XCTAssert(viewModel.upcomingRaces.isEmpty)
    }

    func testComputedProperties_WhenPastAndFutureDates() {
        // Given: Mock races with future and past dates
        viewModel.data = Race.mockRaces()

        // Then
        let allRaces = viewModel.data
        XCTAssertEqual(viewModel.upcomingRaces.count + viewModel.pastRaces.count, allRaces.count)
    }

    func testFetchCurrentRaces_Error() async {
        // Given
        let expectedError = APIError.decodingError(NSError(domain: "Test", code: 0))

        mockF1Service.fetchCurrentRacesHandler = { () async throws -> [Race] in
            throw expectedError
        }

        // When
        await viewModel.fetchCurrentRaces()

        // Then
        XCTAssertTrue(viewModel.data.isEmpty)
        if case .error = viewModel.state {
            XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
        } else {
            XCTFail("Expected error state")
        }
    }
}
