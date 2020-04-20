import XCTest
import UIKit
import Presentation
@testable import UI

class LoginViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }

    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }

    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
}

extension LoginViewControllerTests {
    func makeSut() -> LoginViewController {
        let sut = LoginViewController.instantiate()
        sut.loadViewIfNeeded()
        return sut
    }
}
