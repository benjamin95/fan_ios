//
//  ClientListRetard.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import SwiftUI

struct ClientListRetard: View {
    @StateObject var viewModel: ClientViewModel  = ClientViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var searchTerm = ""
    @State private var moisEnCours = ""
    
    var body: some View {
        NavigationStack{
            
            VStack {
                List(filteredClients) { client in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            ClientDetail(client: client)
                        } label: {
                            Text(client.nom ?? "Inconnu")
                        }
                    }
                }
                .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Recherche Client")
                .listStyle(.plain)
            }
            .task {
                viewModel.getClientsRetard()
                let currentDate = Date()
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM YYYY"
                moisEnCours = dateFormatter.string(from: currentDate)
            }
            
            .navigationTitle("Clients en retard")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Erreur"), message: Text(viewModel.errorMessage!), dismissButton: .default(Text("OK")))
            }
            
        }
    }
    var filteredClients: [Client] {
        guard !searchTerm.isEmpty else { return viewModel.clients }
        return viewModel.clients.filter{
            ($0.nom?.localizedCaseInsensitiveContains(searchTerm) ?? false) ||
            ($0.adresse?.localizedCaseInsensitiveContains(searchTerm) ?? false)
        }
    }
    func printToken() {
        print(JWT.shared.getAccessToken()!)
    }
}

struct ClientListRetard_Previews: PreviewProvider {
    static var previews: some View {
        ClientListRetard()
    }
}
