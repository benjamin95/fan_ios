//
//  NavButton.swift
//  fanv3
//
//  Created by Benjamin Truillet on 08/02/2024.
//

import Foundation
import SwiftUI


func callClient(phoneNumber:String) {
        
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            // Vérifier si le dispositif peut passer un appel et si oui, le faire
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                // Gérer l'erreur si le dispositif ne peut pas passer un appel
            }
        }
    }

func openInWaze(latitude:Double, longitude:Double) {
    
    // Create the URL for Waze
    if let url = URL(string: "waze://?ll=\(latitude),\(longitude)&navigate=yes") {
        // Check if Waze is installed
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // If Waze isn't installed, open the App Store to Waze page
            if let appStoreURL = URL(string: "https://apps.apple.com/app/waze-navigation-live-traffic/id323229106") {
                UIApplication.shared.open(appStoreURL)
            }
        }
    }
}
