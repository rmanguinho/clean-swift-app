import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "any_name", email: String? = "any_email@mail.com", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func makeLoginViewModel(email: String? = "any_email@mail.com", password: String? = "any_password") -> LoginViewModel {
    return LoginViewModel(email: email, password: password)
}
