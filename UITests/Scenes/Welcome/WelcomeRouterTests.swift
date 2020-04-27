import XCTest
import UIKit
import UI

public final class WelcomeRouter {
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController

    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
    }

    public func gotoLogin() {
        nav.pushViewController(loginFactory())
    }
}

class WelcomeRouterTests: XCTestCase {
    func test_gotoLogin_calls_nav_with_correct_vc() {
        let (sut, nav) = makeSut()
        sut.gotoLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }
}

extension WelcomeRouterTests {
    func makeSut() -> (sut: WelcomeRouter, nav: NavigationController) {
        let loginFactorySpy = LoginFactorySpy()
        let nav = NavigationController()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin)
        return (sut, nav)
    }
}


extension WelcomeRouterTests {
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }
}
