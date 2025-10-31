//
//  DriverDetailViewModelTests.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/10/2025.
//

import Combine
@testable import F1Hub
import XCTest

final class DriverDetailViewModelTests: XCTestCase {
    private var viewModel: DriverDetailViewModel!
    private var mockF1Service: MockF1APIService!
    private var mockWikipediaAPIService: MockWikipediaAPIService!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockF1Service = MockF1APIService()
        mockWikipediaAPIService = MockWikipediaAPIService()
        viewModel = DriverDetailViewModel(
            driverId: Driver.mockVerstappen.id,
            wikiUrl: Driver.mockVerstappen.url,
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

    func testFetchDriverDetails_Success() async {
        // Given
        let expectedDriver = Driver.mockVerstappen
        let expectedSummary = Driver.mockVerstappenWikipedia

        mockF1Service.fetchDriverDetailHandler = { _ in
            expectedDriver
        }
        mockWikipediaAPIService.fetchSummaryHandler = { _ in
            expectedSummary
        }

        // When
        await viewModel.fetchDriverDetails()

        // Then
        XCTAssertEqual(viewModel.driver, expectedDriver)
        XCTAssertEqual(viewModel.summary, expectedSummary)
        XCTAssertEqual(viewModel.state, .finished)
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
    }

    func testFetchDriverDetails_F1ServiceError() async {
        // Given
        let expectedError = F1APIError.driverNotFound
        let expectedSummary = Driver.mockVerstappenWikipedia

        mockF1Service.fetchDriverDetailHandler = { _ in
            throw expectedError
        }
        mockWikipediaAPIService.fetchSummaryHandler = { _ in
            expectedSummary
        }

        // When
        await viewModel.fetchDriverDetails()

        // Then
        // if one async task fails, the other is cancelled
        XCTAssertNil(viewModel.driver)
        XCTAssertNil(viewModel.summary)
        if case let .error(error) = viewModel.state {
            XCTAssertEqual(error as? F1APIError, expectedError)
        } else {
            XCTFail("Expected error state")
        }
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
    }

    func testFetchDriverDetails_WikipediaServiceError() async {
        // Given
        let expectedDriver = Driver.mockVerstappen
        let expectedError = APIError.invalidURL

        mockF1Service.fetchDriverDetailHandler = { _ in
            expectedDriver
        }
        mockWikipediaAPIService.fetchSummaryHandler = { _ in
            throw expectedError
        }

        // When
        await viewModel.fetchDriverDetails()

        // Then
        // if one async task fails, the other is cancelled
        XCTAssertNil(viewModel.driver)
        XCTAssertNil(viewModel.summary)
        if case let .error(error) = viewModel.state {
            XCTAssertEqual(error as? APIError, expectedError)
        } else {
            XCTFail("Expected error state")
        }
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
    }

    func testStateChangesToLoading() async {
        // Given
        mockF1Service.fetchDriverDetailHandler = { _ in
            try await Task.sleep(nanoseconds: 1000000) // Simulate delay
            return Driver.mockVerstappen
        }
        mockWikipediaAPIService.fetchSummaryHandler = { _ in
            Driver.mockVerstappenWikipedia
        }

        let stateExpectation = XCTestExpectation(description: "State changes to loading")
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .loading = state {
                    stateExpectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        await viewModel.fetchDriverDetails()

        // Then
        await fulfillment(of: [stateExpectation], timeout: 1.0)
    }
}
