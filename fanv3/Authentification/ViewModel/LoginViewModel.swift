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

    
    @Published var username: String = "cedric"
    @Published var password: String = "smokerz91"
    @Published var errorMessage: String?
    
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
            print(data)
            if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                
                    JWT.shared.setKeychain(accessToken: loginResponse.access, username: self.username)
                
            } else {
                throw FetchError.decodingError
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    
}
