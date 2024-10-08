//
//  TacheManager.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 22/08/2023.
//

import Foundation

class TacheManager {
    
    
    static let shared = TacheManager()

    
    func fetchTachesNonFaites(completion: @escaping (Result<[Tache], APIError>) -> Void) {
        
        guard let jwtToken = JWT.shared.getAccessToken() else {
            print("JWT Indisponible")
            return
        }
        
        guard let username = JWT.shared.getUsername() else {
            print("Nom d'utilisateur non disponible")
            return
        }
        
        guard let apiURL = URL(string: "\(getAPiUrl())taches/?fait=False&technicien__username=\(username)") else {
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
                let taches = try decoder.decode([Tache].self, from: data)
                
                completion(.success(taches))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func editTache(tache: Tache, fait: Bool = true ,completion: @escaping (Result<Tache, APIErrorPost>) -> Void) {
        
        guard let jwtToken = JWT.shared.getAccessToken() else {
            print("JWT Indisponible")
            return
        }
        
        guard let id = tache.id else { return }
        
        guard let apiURL = URL(string: "\(getAPiUrl())taches/\(id)/") else {
            print("URL invalide")
            return
        }
        
        print(apiURL)
        
        var request = URLRequest(url: apiURL)
        request.addValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        let tache = TachePost(id: tache.id, faitLe: dateString, fait: fait)
        print(tache)
        
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            request.httpBody = try encoder.encode(tache)
            
        } catch {
            completion(.failure(.encodingError))
            return
        }
        
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
                let tache = try decoder.decode(Tache.self, from: data)
                completion(.success(tache))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
        
    }
    
    
    func fetchTaches(completion: @escaping (Result<[Tache], APIError>) -> Void) {
        
        guard let jwtToken = JWT.shared.getAccessToken() else {
            print("JWT Indisponible")
            return
        }
        
        guard let username = JWT.shared.getUsername() else {
            print("Nom d'utilisateur non disponible")
            return
        }
        
        guard let apiURL = URL(string: "\(getAPiUrl())taches/?technicien__username=\(username)") else {
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
                let taches = try decoder.decode([Tache].self, from: data)
                completion(.success(taches))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
