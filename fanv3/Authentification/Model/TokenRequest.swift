//
//  TokenRequest.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import Foundation

/// API Token
struct TokenRequest: Codable {
    /// Token a envoyer a l'API
    var token: String
}
