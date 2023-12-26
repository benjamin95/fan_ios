//
//  LoginResponse.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 18/08/2023.
//

import Foundation

struct LoginResponse: Decodable {
    var access: String
    var refresh: String
}
