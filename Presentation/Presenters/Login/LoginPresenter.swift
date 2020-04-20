import Foundation
import Domain

public final class LoginPresenter {
    private let validation: Validation
    private let alertView: AlertView
    private let authentication: Authentication

    public init(validation: Validation, alertView: AlertView, authentication: Authentication) {
        self.validation = validation
        self.alertView = alertView
        self.authentication = authentication
    }

    public func login(viewModel: LoginViewModel) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            authentication.auth(authenticationModel: viewModel.toAuthenticationModel()) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    var errorMessage: String!
                    switch error {
                    case .expiredSession:
                    errorMessage = "Email e/ou senha inválido(s)."
                    default:
                    errorMessage = "Algo inesperado aconteceu, tente novamente em alguns instantes."
                    }
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                case .success: break
                }
            }
        }
    }
}
