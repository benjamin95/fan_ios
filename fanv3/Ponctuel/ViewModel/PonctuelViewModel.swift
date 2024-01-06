//
//  PonctuelViewModel.swift
//  fanv3
//
//  Created by Benjamin Truillet on 26/12/2023.
//

import Foundation

class PonctuelViewModel: ObservableObject {
    
    @Published var ponctuels = [Ponctuel]()
    @Published var ponctuelsFait = 0
    @Published var ponctuelsNonFait = 0
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    

    func getTachesNonFaites()  {
        
        PonctuelManager.shared.fetchPonctuelNonFait { [self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let ponctuels):
                    self.ponctuels = ponctuels
                    self.ponctuelsNonFait = ponctuels.count
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
