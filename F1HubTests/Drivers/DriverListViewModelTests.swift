//
//  DriverListViewModelTests.swift
//  F1Hub
//
//  Created by Marcos Morales on 27/10/2025.
//

import Combine
@testable import F1Hub
import XCTest

final class DriverListViewModelTests: XCTestCase {
    private var viewModel: DriverListViewModel!
    private var mockF1Service: MockF1APIService!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockF1Service = MockF1APIService()
        viewModel = DriverListViewModel(f1APIService: mockF1Service)
    }

    override func tearDown() {
        viewModel = nil
        mockF1Service = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchCurrentDrivers_Success() async {
        // Given
        let expectedDrivers = Driver.mockDrivers()

        mockF1Service.fetchCurrentDriversHandler = { () async throws -> [Driver] in
            expectedDrivers
        }

        // When
        await viewModel.fetchCurrentDrivers()

        // Then
        XCTAssertEqual(viewModel.data, expectedDrivers)
        XCTAssertEqual(viewModel.state, .finished)
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
    }

    func testFetchCurrentDrivers_Error() async {
        // Given
        let expectedError = APIError.networkError(NSError(domain: "Test", code: 0))

        mockF1Service.fetchCurrentDriversHandler = { () async throws -> [Driver] in
            throw expectedError
        }

        // When
        await viewModel.fetchCurrentDrivers()

        // Then
        XCTAssertTrue(viewModel.data.isEmpty)
        if case let .error(error) = viewModel.state {
            XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
        } else {
            XCTFail("Expected error state")
        }
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
    }

    func testDataIsEmptyInitially() {
        // Given & When
        let initialDataExpectation = XCTestExpectation(description: "Initial data is empty")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            initialDataExpectation.fulfill()
        }

        // Then
        XCTAssertTrue(viewModel.data.isEmpty)
        wait(for: [initialDataExpectation], timeout: 1.0)
    }
}
