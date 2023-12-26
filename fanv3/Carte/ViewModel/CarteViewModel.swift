//
//  CarteViewModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 23/08/2023.
//

import Foundation
import SwiftUI
import MapKit

class CarteViewModel: ObservableObject {
    
    @Published var clientsCarte : [Location] = [Location]()
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var locations: [Location] = [Location]()
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var showLocationsList: Bool = false

    @Published var mapLocation: Location {
        didSet {
            DispatchQueue.main.async {
                self.updateMapRegion(location: self.mapLocation)
            }
        }
    }
    
    
    var mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        self.mapLocation = Location(nom: "AUCHAN", adresse: "", ville: "Paris", codePostal: 0, telFixe: "", telPortable: "", contact: "", lat: 37.7749, lng: -122.4194)
        self.getClients()
    }
    
    private func updateMapRegion(location: Location) {
        DispatchQueue.main.async {
            withAnimation(.easeInOut){
                self.self.self.mapRegion = MKCoordinateRegion(
                    center: location.coordinates,
                    span: self.mapSpan)
            }
        }
    }
    
    func toggleLocationList() {
        DispatchQueue.main.async {
            withAnimation(.easeInOut){
                self.showLocationsList = !self.showLocationsList
            }
            
        }
    }
    
    func showNextLocation(location:Location) {
        DispatchQueue.main.async {
            withAnimation(.easeInOut){
                self.mapLocation = location
                self.showLocationsList = false
            }
        }
    }
    
    func nextButtonPressed() {
        DispatchQueue.main.async { [self] in
            guard let currentIndex = locations.firstIndex(where: {$0 == self.mapLocation }) else {
                print("Could not find current index")
                return
            }
            let nextIndex = currentIndex + 1
            guard locations.indices.contains(nextIndex) else {
                
                guard let firstLocation = locations.first else {return}
                self.showNextLocation(location: firstLocation )
                return
            }
            
            let nextLocation = locations[nextIndex]
            self.showNextLocation(location: nextLocation)
        }
    }
    func getClients()  {
        
        ClientManager.shared.fetchClients() { [self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let clients):
                    self.clientsCarte = self.convertClientsToLocations(clients: clients)
                    self.locations = self.clientsCarte
                    self.mapLocation = self.locations.first!
                    self.mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    self.updateMapRegion(location: self.locations.first!)
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
    
    func convertClientsToLocations(clients: [Client]) -> [Location] {
        return clients.map { client in
            Location(
                nom: client.nom!,
                adresse: client.adresse!,
                ville: client.ville ?? "Pas de ville",
                codePostal: client.codePostal ?? 0,
                telFixe: client.telFixe!,
                telPortable: client.telPortable ?? "Pas de Portable",
                contact: client.contact ?? "Pas de contact",
                lat: Double(client.lat!) ?? 0,
                lng: Double(client.lng!) ?? 0
            )
        }
    }
}
