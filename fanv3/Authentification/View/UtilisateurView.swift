//
//  UtilisateurView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import SwiftUI

struct UtilisateurView: View {
    
    @State private var text = JWT.shared.getAccessToken()!
    @State private var username = JWT.shared.getUsername()!
    @State private var dateObt = JWT.shared.getJwtToken().dateObtention!
    @State private var dateExp = JWT.shared.getJwtToken().dateExpiration!
    @State private var isLoogedIn = JWT.shared.loggedIn
    @State private var isExpired = true
    @State private var timestamp: TimeInterval = 0.0
    
    
    
    
    
    
    var body: some View {
        
        NavigationStack{
            
            VStack {
                
                Toggle(isOn: $isLoogedIn) {
                    Text("Logged ?")
                }
                .padding()
                
                
                Toggle(isOn: $isExpired) {
                    Text("Token expiré ?")
                }
                .padding()
                
                TextField("Nom d'utilisateur", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                
                Text("Date Obtention: \(dateObt)")
                    .padding(.horizontal)
                
                Text("Date Expiration: \(dateExp)")
                    .padding(.horizontal)
                
                TextEditor(text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button(action: {
                    Task{
                        await onButtonPress()
                    }
                    
                }) {
                    Text("Refersh Token")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 20) {
                    
                    Button(action: printToken, label: {
                        
                        Image(systemName: "person.fill")
                        Text(JWT.shared.getUsername()!.capitalized)
                    }).buttonStyle(.bordered)
                    
                }
                .foregroundColor(Color.blue)
            }
        }
        
    }
    
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
    
    func onButtonPress() async {
     
//        let tokenManager: TokenManager = TokenManager()
//        
//        print(tokenManager.jwtToken.accessToken!)
//        
//        isExpired = tokenManager.expired
//        dateObt = tokenManager.dateObtention
//        dateExp = tokenManager.dateExpiration
//        
//        do {
//            guard let currentToken = tokenManager.jwtToken.accessToken else {
//                print("No token to refresh.")
//                return
//            }
//            let newToken = try await tokenManager.refreshToken(tokenToRefresh: currentToken)
//            print("New Token:", newToken)
//            print("Ancien Token:", currentToken)
//            DispatchQueue.main.async {
//                self.text = newToken
//            }
//        } catch {
//            print("Error refreshing token:", error)
//        }
//        
    }
    
}
func printToken() {
    print(JWT.shared.getAccessToken()!)
}


struct UtilisateurView_Previews: PreviewProvider {
    static var previews: some View {
        UtilisateurView()
    }
}
