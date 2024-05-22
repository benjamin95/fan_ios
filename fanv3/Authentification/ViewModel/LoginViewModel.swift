//
//  LoginViewModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 18/08/2023.
//

import Foundation

enum FetchError: Error, LocalizedError {
    case decodingError

    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Erreur lors du décodage des données."
        }
    }
}


class LoginViewModel: ObservableObject {

    
    @Published var username: String = "redak"
    @Published var password: String = "koko93500"
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false

    /// Login via l'api
    func login() async {
        let url = URL(string: "\(getAPiUrl())token/")!
        let loginRequest = LoginRequest(username: username, password: password)
        do {
            let requestData = try JSONEncoder().encode(loginRequest)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = requestData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                JWT.shared.setKeychain(accessToken: loginResponse.access, username: self.username)
                print("Logged In", JWT.shared.getAccessToken() ?? "pas de token")
            } else {
                throw FetchError.decodingError
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func performAuthenticatedRequest() async {
        if JWT.shared.isTokenExpired() {
            do {
                try await JWT.shared.refreshToken()
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Erreur lors du rafraîchissement du jeton."
                }
                return
            }
        }
        
        // Effectuer la requête authentifiée ici
    }
    
    
}
