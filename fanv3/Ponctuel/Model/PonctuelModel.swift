//
//  PonctuelModel.swift
//  fanv3
//
//  Created by Benjamin Truillet on 26/12/2023.
//

import Foundation

//
//  TacheModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 22/08/2023.
//

import Foundation

struct Ponctuel: Codable, Identifiable {
    var id: Int?
    var dateInter: String?
    var nom: String?
    var adresse: String?
    var telFixe: String?
    var telPortable: String?
    var contact: String?
    var heureInter: String?
    var fait: Bool?
    var lat: String?
    var lng: String?
    var note: String?
    var technicien: Int?
}

