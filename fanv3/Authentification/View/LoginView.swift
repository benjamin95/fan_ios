//
//  LoginView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 18/08/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {

        VStack {
            if let errorMessage = loginViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            TextField("Username", text: $loginViewModel.username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            SecureField("Password", text: $loginViewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            Button("Login") {
                Task {
                    await loginViewModel.login()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(LoginViewModel())
    }
}
