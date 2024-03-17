//
//  Convert.swift
//  fanv3
//
//  Created by Benjamin Truillet on 01/02/2024.
//

import Foundation


func convertStringToDouble(_ inputString: String) -> Double? {
    // Utilisez la fonction Double() pour tenter de convertir la chaîne en Double
    if let convertedValue = Double(inputString) {
        return convertedValue
    } else {
        // La conversion a échoué, retourne nil (optionnel)
        return nil
    }
}

func convertIntToString(_ number: Int?) -> String? {
    if let num = number {
        return String(num)
    } else {
        return nil
    }
}
