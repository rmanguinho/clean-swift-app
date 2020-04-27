import Foundation

public final class WelcomeRouter {
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    private let signUpFactory: () -> SignUpViewController

    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController, signUpFactory: @escaping () -> SignUpViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
    }

    public func gotoLogin() {
        nav.pushViewController(loginFactory())
    }

    public func gotoSignUp() {
        nav.pushViewController(signUpFactory())
    }
}
