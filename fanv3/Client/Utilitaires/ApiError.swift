//
//  ApiError.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case dataMissing
    case decodingError
    case serverError(String)
}

enum APIErrorPost: Error {
    case invalidResponse
    case dataMissing
    case decodingError
    case serverError(String)
    case encodingError
}
