//
//  AppConfig.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 24/08/2023.
//

import Foundation

struct AppConfig {
    static let apiURLdev:String = "http://192.168.1.171:8000/api/v2/"
    static let apiURLprod:String = "https://fandev.taxis-bretigny.fr/api/v2/"
    static let modeProd:Bool = true
}

func getAPiUrl() -> String {
    
    if AppConfig.modeProd {
        return AppConfig.apiURLprod
    }
    else{
        return AppConfig.apiURLdev
    }
}
