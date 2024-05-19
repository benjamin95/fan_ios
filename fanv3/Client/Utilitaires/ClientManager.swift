//
//  ClientManager.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//
import Foundation
import SwiftUI


struct Total: Codable, Hashable {
    var total: Int
}

class ClientManager {
    
    private var jwtToken: String
    static let shared = ClientManager()
    
    init() {
        
        self.jwtToken = ""
        guard let accessToken = JWT.shared.getAccessToken() else {
            print("JWT Indisponible")
            return
        }
        self.jwtToken = accessToken
    }
    
    func fetchClients(completion: @escaping (Result<[Client], APIError>) -> Void) {
        
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
    
    func fetchClientsAFaire(completion: @escaping (Result<[Client], APIError>) -> Void) {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        
        
        guard let username = JWT.shared.getUsername() else {
            
            print("Nom d'utilisateur non disponible")
            return
        }
        
        guard let apiURL = URL(string: "\(getAPiUrl())clients/?ordering=derniere_inter&prochaine_inter__month=\(month)&prochaine_inter__year=\(year)&technicien__username=\(username)") else {
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
    
    func fetchClientsRetard(completion: @escaping (Result<[Client], APIError>) -> Void) {
        
        guard let username = JWT.shared.getUsername() else {
            
            print("Nom d'utilisateur non disponible")
            return
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        
        let startOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let endOfLastMonth = calendar.date(byAdding: .day, value: -1, to: startOfCurrentMonth)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: endOfLastMonth)
        
        guard let apiURL = URL(string: "\(getAPiUrl())clients/?ordering=derniere_inter&prochaine_inter__lte=\(formattedDate)&technicien__username=\(username)") else {
            
            print("URL invalide")
            return
        }
        
        print(apiURL)
        
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
                print(clients)
                completion(.success(clients))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
