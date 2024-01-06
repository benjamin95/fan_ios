//
//  CountManager.swift
//  fanv3
//
//  Created by Benjamin Truillet on 06/01/2024.
//

import Foundation

class CountManager {
    
    private var jwtToken: String
    static let shared = CountManager()
    
    init() {
        
        self.jwtToken = ""
        guard let accessToken = JWT.shared.getAccessToken() else {
            print("JWT Indisponible")
            return
        }
        self.jwtToken = accessToken
    }
    
    func fetchCountClients(completion: @escaping (Result<[Client], APIError>) -> Void) {
        
        guard let username = JWT.shared.getUsername() else {
            print("Nom d'utilisateur non disponible")
            return
        }
        
        guard let apiURL = URL(string: "\(getAPiUrl())clients/?ordering=derniere_inter&technicien__username=\(username)") else {
            print("URL invalide")
            return
        }
        
        var request = URLRequest(url: apiURL)
        request.addValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.dataMissing))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let clients = try decoder.decode([Client].self, from: data)
                completion(.success(clients))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
}
