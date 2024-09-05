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
    @Published var tokenExpired: Bool = false
    
    init() {
        loggedIn = hasAccessToken()
        checkTokenStatus()
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
            print("Erreur lors de la décodage du JWT : \(error.localizedDescription)")
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
    
    func checkTokenStatus() {
        if isTokenExpired() {
            self.logout()
        } else {
            self.loggedIn = true
        }
    }
    
    func isTokenExpired() -> Bool {
        guard let expirationString = keychain.get("dateExpiration"),
              let expirationTime = Double(expirationString) else {
            return true
        }
        let expirationDate = Date(timeIntervalSince1970: expirationTime)
        return expirationDate <= Date()
    }
    
    func refreshToken() async throws {
        guard let refreshToken = keychain.get("refreshToken") else {
            throw FetchError.decodingError
        }
        
        let url = URL(string: "\(getAPiUrl())token/refresh/")!
        let tokenRequest = TokenRequest(token: refreshToken)
        let requestData = try JSONEncoder().encode(tokenRequest)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
            setKeychain(accessToken: loginResponse.access, username: getUsername() ?? "")
        } else {
            throw FetchError.decodingError
        }
    }
    
}
