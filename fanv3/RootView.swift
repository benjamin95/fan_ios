//
//  RootView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 18/08/2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var JWT: JWT
    
    var body: some View {
        if JWT.loggedIn {
            DashBoardView()
        } else {
            LoginView()
        }
    }
}
