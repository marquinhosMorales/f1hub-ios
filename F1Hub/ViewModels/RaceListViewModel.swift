//
//  RaceListViewModel.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/04/2025.
//

import Foundation

class RaceListViewModel: BaseViewModel {
    @Published var data: [Race] = []
    
    private let f1APIService = F1APIService()
    
    @MainActor
    func fetchCurrentraces() async {
        state = .loading
        
        do {
            let races = try await f1APIService.fetchCurrentRaces()
            data = races
            state = .finished
        } catch {
            state = .error(error)
        }
    }
}
