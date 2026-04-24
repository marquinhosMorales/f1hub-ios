import SwiftUI

extension View {
    @ViewBuilder
    func loadingOverlay(_ isLoading: Bool, dimBackground: Bool = false) -> some View {
        ZStack {
            self
            if isLoading {
                if dimBackground {
                    Color.black.opacity(0.15)
                        .ignoresSafeArea()
                }
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
    }
}
