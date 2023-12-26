//
//  TacheViewModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 22/08/2023.
//

import Foundation

class TacheViewModel: ObservableObject {
    
    @Published var taches = [Tache]()
    @Published var tachesFaites = 0
    @Published var tachesNonFaites = 0
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    
    func editTache(tache: Tache, fait: Bool = true) {
        TacheManager.shared.editTache(tache: tache, fait: fait) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("Success Edit")
                case .failure(let error):
                    var errorMessage = "Une erreur est survenue."
                    switch error {
                    case .encodingError:
                        errorMessage = "Erreur encoding Tache"
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
    
    
    func getTachesNonFaites()  {
        
        TacheManager.shared.fetchTachesNonFaites() { [self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let taches):
                    self.taches = taches
                    self.tachesNonFaites = taches.count
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
    
    func getTaches()  {
        
        TacheManager.shared.fetchTaches() { [self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let taches):
                    self.taches = taches
                    self.tachesFaites = taches.count
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
