import Foundation
import UIKit
import Presentation

public final class LoginViewController: UIViewController, Storyboarded {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        title = "4Dev"
        loginButton?.layer.cornerRadius = 5
        hideKeyboardOnTap()
    }
}
