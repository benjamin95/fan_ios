//
//  JwtTokenModel.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 21/08/2023.
//

import Foundation

struct JwtToken {
    var accessToken: String?
    var username: String?
    var userId: String?
    var email: String?
    var dateExpiration: String?
    var dateObtention: String?
}
