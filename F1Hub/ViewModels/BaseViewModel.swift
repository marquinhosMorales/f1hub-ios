//
//  BaseViewModel.swift
//  F1Hub
//
//  Created by Marcos Morales on 11/04/2025.
//

import SwiftUI

class BaseViewModel: ObservableObject {
    enum State: Equatable {
        case idle,
             loading,
             error(Error),
             finished

        static func ==(lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): fallthrough
            case (.loading, .loading): fallthrough
            case (.finished, .finished): fallthrough
            case (.error(_), .error(_)):
                return true
            default:
                return false
            }
        }
    }
    
    @Published var state = State.idle {
        didSet {
            switch state {
            case .error(let error):
                errorMessage = error.localizedDescription
            default:
                errorMessage = ""
            }
        }
    }
    
    var isFinished: Bool {
        state == .finished
    }
    
    var isPresentingError: Binding<Bool> {
        Binding<Bool> {
            !self.errorMessage.isEmpty
        } set: { newValue in
            guard !newValue else { return }
            self.errorMessage = ""
        }
    }
    
    private(set) var errorMessage = ""
}
