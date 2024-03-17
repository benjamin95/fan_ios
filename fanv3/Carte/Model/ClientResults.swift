//
//  ClientResults.swift
//  fanv3
//
//  Created by Benjamin Truillet on 13/01/2024.
//

import Foundation
import MapKit

struct ClientResult: Identifiable, Hashable, Equatable {
    
    init(location: CLLocationCoordinate2D, nom: String, adresse: String) {
        self.location = location
        self.nom = nom
        self.adresse = adresse
    }
    
    let id = UUID()
    let location: CLLocationCoordinate2D
    let nom: String
    let adresse: String

    static func == (lhs: ClientResult, rhs: ClientResult) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Place: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
}
