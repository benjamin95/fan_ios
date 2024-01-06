//
//  PonctuelManager.swift
//  fanv3
//
//  Created by Benjamin Truillet on 26/12/2023.
//

import Foundation

class PonctuelManager {
    
    private let jwtToken: String
    static let shared = PonctuelManager()
    
    init() {
        guard let accessToken = JWT.shared.getAccessToken() else {
            fatalError("Token d'accès non disponible")
        }
        self.jwtToken = accessToken
        
    }
    
    func fetchPonctuelNonFait(completion: @escaping (Result<[Ponctuel], APIError>) -> Void) {
        
        guard let userId = JWT.shared.getUserId() else {
            print("Userid non disponible")
            return
        }
        
        //http://0.0.0.0:8000/api/v2/ponctuels/?technicien=3&fait=true
        
        guard let apiURL = URL(string: "\(getAPiUrl())ponctuels/?fait=false&technicien=\(userId)") else {
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
                let ponctuels = try decoder.decode([Ponctuel].self, from: data)
                print(ponctuels)
                completion(.success(ponctuels))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func editTache(tache: Tache, fait: Bool = true ,completion: @escaping (Result<Tache, APIErrorPost>) -> Void) {
        
        
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
