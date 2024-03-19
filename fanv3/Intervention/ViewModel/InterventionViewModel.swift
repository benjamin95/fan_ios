//
//  InterventionViewModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import Foundation

class InterventionViewModel: ObservableObject {
    
    @Published var interventions =  [Intervention]()
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var isPresented: Bool = false
    
    func getInterventionsParMois() {
        
        InterventionManager.shared.fetchInterventionsParMois() { [self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let interventions):
                    //print(interventions)
                    self.interventions = interventions
                case .failure(let error):
                    var errorMessage = "Une erreur est survenue."
                    switch error {
                    case .encodingError:
                        errorMessage = "Erreur encodage Intervention"
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
    
    func ajoutIntervention(intervention: Intervention) {
        
        InterventionManager.shared.addIntervention(intervention: intervention) { [self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let intervention):
                    //print(intervention)
                    self.isPresented = false
                case .failure(let error):
                    var errorMessage = "Une erreur est survenue."
                    switch error {
                    case .encodingError:
                        errorMessage = "Erreur encodage Intervention"
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
