//
//  AppConfig.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 24/08/2023.
//

import Foundation

struct AppConfig {
    static let apiURLdev:String = "https://fan.b-tech.ovh/api/v2/"
    static let apiURLprod:String = "https://fandev.taxis-bretigny.fr/api/v2/"
    static let modeProd:Bool = false
}

func getAPiUrl() -> String {
    
    if AppConfig.modeProd {
        return AppConfig.apiURLprod
    }
    else{
        return AppConfig.apiURLdev
    }
}
