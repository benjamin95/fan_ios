//
//  InterventionManager.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import Foundation
import SwiftUI

class InterventionManager: ObservableObject {
    
    private let jwtToken: String
    static let shared = InterventionManager()
    
    init() {
        self.jwtToken = JWT.shared.getAccessToken() ?? ""
    }
    
    
    func fetchInterventionsParMois(mois: String? = nil, annee: String? = nil ,  completion: @escaping (Result<[Intervention], APIErrorPost>) -> Void){
        
        var url:String
        let username = JWT.shared.getUsername()
        let currentDate = Date()
        let calendar = Calendar.current

        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        if let mois = mois, let annee = annee {
            
            url = "\(getAPiUrl())interventions/?date__month=\(mois)&date__year=\(annee)&ordering=-date&technicien__username=\(username!)"
        }
        else{
            
            
            url = "\(getAPiUrl())interventions/?date__month=\(month)&date__year=\(year)&ordering=-date&technicien__username=\(username!)"
        }
        
        
        
        let apiURL = URL(string: url)!
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
                let interventions = try decoder.decode([Intervention].self, from: data)
                completion(.success(interventions))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    
    func addIntervention(intervention: Intervention, completion: @escaping (Result<Intervention, APIErrorPost>) -> Void) {
        
        
        let apiURL = URL(string: "\(getAPiUrl())interventions/")!
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            request.httpBody = try encoder.encode(intervention)
            
        } catch {
            completion(.failure(.encodingError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataMissing))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 400 {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let intervention = try decoder.decode(Intervention.self, from: data)
                completion(.success(intervention))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()

    
    }
    
}
