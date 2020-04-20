import XCTest
import UIKit
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }

    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }

    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }

    func test_saveButton_calls_signUp_on_tap() {
        var signUpViewModel: SignUpViewModel?
        let sut = makeSut(signUpSpy: { signUpViewModel = $0 })
        sut.saveButton?.simulateTap()
        let name = sut.nameTextField?.text
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        let passwordConfirmation = sut.passwordConfirmationTextField?.text
        XCTAssertEqual(signUpViewModel, SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation))
    }
}

extension SignUpViewControllerTests {
    func makeSut(signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sut = SignUpViewController.instantiate()
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return sut
    }
}
