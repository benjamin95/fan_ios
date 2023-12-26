//
//  CarteClientModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 23/08/2023.
//

import Foundation
import CoreLocation

class Location: Identifiable, Equatable{
    
     init(nom: String, adresse: String, ville: String, codePostal: Int, telFixe: String, telPortable: String, contact: String, lat: Double, lng: Double) {
        self.nom = nom
        self.adresse = adresse
        self.ville = ville
        self.codePostal = codePostal
        self.telFixe = telFixe
        self.telPortable = telPortable
        self.contact = contact
        self.lat = lat
        self.lng = lng
    }

    var nom: String?
    var adresse: String?
    var ville: String?
    var codePostal: Int?
    var telFixe: String?
    var telPortable: String?
    var contact: String?
    var lat: Double?
    var lng: Double?
    
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
    }
    
    var id: String {
        nom! + ville!
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
