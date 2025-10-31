//
//  DriverListViewModel.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import Foundation

class DriverListViewModel: BaseViewModel {
    @Published var data: [Driver] = []

    private let f1APIService: F1APIServiceProtocol

    init(f1APIService: F1APIServiceProtocol = AppDependencyContainer.shared.f1APIService) {
        self.f1APIService = f1APIService
        super.init()
    }

    @MainActor
    func fetchCurrentDrivers() async {
        state = .loading

        do {
            let drivers = try await f1APIService.fetchCurrentDrivers()
            data = drivers
            state = .finished
        } catch {
            state = .error(error)
        }
    }
}
