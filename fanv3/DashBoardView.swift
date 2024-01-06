//
//  TestView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 18/08/2023.
//

import SwiftUI

struct DashBoardView: View {
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                HStack(spacing: 15){
                    NavigationLink {
                        ClientListView()
                    } label: {
                        DashboardItemClients()
                    }
                    NavigationLink {
                        ClientListRetard()
                    } label: {
                        DashboardItemRetard()
                    }
                }
                HStack(spacing: 15){
                    NavigationLink {
                        ClientListAFaire()
                    } label: {
                        DashboardItemAFaire()
                    }
                }
                HStack(spacing: 15){
                    NavigationLink {
                        TacheListView()
                    } label: {
                        DashboardItemTaches()
                    }
                }
                HStack(spacing: 15){
                    NavigationLink {
                        PonctuelListView()
                    } label: {
                        DashboardItemPonctuels()
                    }
                }
                HStack(spacing: 15){
                    DashboardInterventionsMois()
                }
                HStack(spacing: 15){
                    NavigationLink {
                        CarteView()
                    } label: {
                        DashboardItemCarte()
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Dashboard")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink {
                            
                        } label: {
                            Image(systemName: "person.fill")
                            Text(JWT.shared.getUsername()!.capitalized)
                        }
                        .buttonStyle(.bordered)
                        Button(action: JWT.shared.logout, label: {
                            Label("Home", systemImage: "rectangle.portrait.and.arrow.right")
                            
                        }).buttonStyle(.bordered)
                    }
                }
            }
        }
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
