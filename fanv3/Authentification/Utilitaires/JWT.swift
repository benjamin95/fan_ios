//
//  JWT.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 18/08/2023.
//

import Foundation


import Foundation
import KeychainSwift
import JWTDecode



class JWT: ObservableObject {
    
    static let shared: JWT = JWT()
    private let keychain: KeychainSwift = KeychainSwift()
    
    @Published var loggedIn: Bool = false
    
     init() {
         print("Init JWT Auth")
        loggedIn = hasAccessToken()
    }
    
    func getJwtToken() -> JwtToken {
        
        return JwtToken(
            accessToken: keychain.get("jwt"),
            username: keychain.get("username"),
            userId: keychain.get("userId"),
            dateExpiration: keychain.get("dateExpiration"),
            dateObtention: keychain.get("dateObtention")
        )
    }
    
    func setKeychain(accessToken: String, username: String) {
        
        do {
            let jwt = try decode(jwt: accessToken)
            let body = jwt.body
            print("Corps du JWT : \(body)")
            let username = username
            let user_id = String(describing: body["user_id"]!)
            let dateObtention = String(describing: body["iat"]!)
            let dateExpiration  = String(describing: body["exp"]!)
            let accessToken = String(describing: accessToken)
            
            keychain.set(accessToken, forKey: "jwt")
            keychain.set(username, forKey: "username")
            keychain.set(user_id, forKey: "userId")
            keychain.set(dateObtention, forKey: "dateObtention")
            keychain.set(dateExpiration, forKey: "dateExpiration")
            
            DispatchQueue.main.async {
                self.loggedIn = true
            }
        } catch {
            print("Erreur lors de la décodage du JWT : \(error)")
        }
        
        
    }

    func hasAccessToken() -> Bool {
        return getJwtToken().accessToken != nil
    }
    
    func getAccessToken() -> String? {
        return getJwtToken().accessToken
    }
    
    func getUsername() -> String? {
        return getJwtToken().username
    }
    
    func getUserId() -> String? {
        return getJwtToken().userId
    }

    func logout() {
        keychain.clear()
        DispatchQueue.main.async {
            self.loggedIn = false
        }
    }
    
}
