//
//  TacheModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 22/08/2023.
//

import Foundation

struct Tache: Codable, Identifiable {
    var id: Int?
    var client: Client?
    var faitLe: String?
    var dateCreation: String?
    var fait: Bool?
    var tache: String?
    var technicien: Int?
}

struct TachePost: Codable, Identifiable {
    var id: Int?
    var faitLe: String?
    var fait: Bool?
}
