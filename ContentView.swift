//
//  ContentView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 18/08/2023.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var vm = CarteViewModel()
    
    var body: some View {
        RootView().environmentObject(JWT.shared).environmentObject(vm)
    }
}

