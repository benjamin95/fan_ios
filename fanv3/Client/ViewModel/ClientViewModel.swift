//
//  ClientViewModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 19/08/2023.
//

import Foundation


class ClientViewModel: ObservableObject {
    
    @Published var clients = [Client]()
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    
    func getClients()  {
        
        ClientManager.shared.fetchClients() { [self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let clients):
                    self.clients = clients
                case .failure(let error):
                    var errorMessage = "Une erreur est survenue."
                    switch error {
                    case .invalidResponse:
                        errorMessage = "Réponse invalide de l'API."
                    case .dataMissing:
                        errorMessage = "Données manquantes dans la réponse."
                    case .decodingError:
                        errorMessage = "Erreur lors de la décodage des données."
                    case .serverError(let message):
                        errorMessage = "Erreur serveur: \(message)"
                    }
                    
                    self.errorMessage = errorMessage
                    self.showAlert = true
                }
            }
        }
    }
    
    func getClientsAFaire()  {
        
        ClientManager.shared.fetchClientsAFaire() { [self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let clients):
                    self.clients = clients
                case .failure(let error):
                    var errorMessage = "Une erreur est survenue."
                    switch error {
                    case .invalidResponse:
                        errorMessage = "Réponse invalide de l'API."
                    case .dataMissing:
                        errorMessage = "Données manquantes dans la réponse."
                    case .decodingError:
                        errorMessage = "Erreur lors de la décodage des données."
                    case .serverError(let message):
                        errorMessage = "Erreur serveur: \(message)"
                    }
                    
                    self.errorMessage = errorMessage
                    self.showAlert = true
                }
            }
        }
    }
    
    func getClientsRetard()  {
        
        ClientManager.shared.fetchClientsRetard() { [self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let clients):
                    self.clients = clients
                case .failure(let error):
                    var errorMessage = "Une erreur est survenue."
                    switch error {
                    case .invalidResponse:
                        errorMessage = "Réponse invalide de l'API."
                    case .dataMissing:
                        errorMessage = "Données manquantes dans la réponse."
                    case .decodingError:
                        errorMessage = "Erreur lors de la décodage des données."
                    case .serverError(let message):
                        errorMessage = "Erreur serveur: \(message)"
                    }
                    
                    self.errorMessage = errorMessage
                    self.showAlert = true
                }
            }
        }
    }
}
