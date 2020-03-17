import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    var emit: ((LoadingViewModel) -> Void)?

    func observe(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }

    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
