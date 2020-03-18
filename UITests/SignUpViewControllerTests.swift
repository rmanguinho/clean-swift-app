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
        var callsCount = 0
        let sut = makeSut(signUpSpy: { _ in
            callsCount += 1
        })
        sut.saveButton?.simulateTap()
        XCTAssertEqual(callsCount, 1)
    }
}

extension SignUpViewControllerTests {
    func makeSut(signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }

    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
