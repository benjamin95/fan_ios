//
//  InterventionModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 19/08/2023.
//

import Foundation

struct Intervention: Codable, Hashable, Identifiable {
    let date: String?
    let note: String?
    let typeIntervention: String?
    let technicien: Int?
    let client: Int?
    let id: Int
}

struct InterventionNom: Codable, Hashable, Identifiable {
    let date: String?
    let note: String?
    let typeIntervention: String?
    let technicien: Int?
    let client: String?
    let id: Int
}
