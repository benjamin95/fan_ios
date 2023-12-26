//
//  ClientModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 19/08/2023.
//

import Foundation

struct Client: Codable, Identifiable, Hashable {

    let id: Int
    let nom: String?
    let adresse: String?
    let ville: String?
    let codePostal: Int?
    let telFixe: String?
    let telPortable: String?
    let contact: String?
    let derniereInter: String?
    let statutMagasin: String?
    let prestation: String?
    let delaiProchaineInter: Int?
    let prochaineInter: String?
    let lat: String?
    let lng: String?
    let interventions: [Intervention]?
    
}
